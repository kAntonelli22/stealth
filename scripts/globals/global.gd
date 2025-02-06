extends Node


# ---- # save game stuff # ---- #
var save_game_placeholder : bool = true
var games_played : int = 0

# ---- # resources # ---- #
var player_stats := preload("res://resources/player_stats.tres")
var perk := preload("res://resources/perk.tres")

# ---- # assets # ---- #
var godot_icon := preload("res://icon.svg")

# ---- # scenes # ---- #
var card_select := preload("res://scenes/card_carousel.tscn")
var card := preload("res://scenes/card.tscn")

var guard_scene := preload("res://scenes/enemy.tscn")
var target_scene := preload("res://scenes/target.tscn")

var melee := preload("res://scenes/melee.tscn")

# ---- # card variables # ---- #
var show_perks : bool = false    # used by card carousel to determine if perks should be offered
var perk_deck = {
   "speed": {
      "title": "Speed Perk",
      "image": godot_icon,
      "description": "increases the players speed",
      "value": 50
      },
   "strength": {
      "title": "Strength Perk",
      "image": godot_icon,
      "description": "increases the players strength",
      "value": 50
      },
   "health": {
      "title": "Health Perk",
      "image": godot_icon,
      "description": "increases the players health",
      "value": 50
      },
}
var maps = {
   "map1": {
      "title": "Map 1",
      "image": godot_icon,
      "description": "Guards ... 3\nTargets ... 1",
      "value": preload("res://scenes/test_map.tscn")
      },
   "map2": {
      "title": "Map 1",
      "image": godot_icon,
      "description": "Guards ... 3\nTargets ... 1",
      "value": preload("res://scenes/test_map.tscn")
      },
   "map3": {
      "title": "Map 1",
      "image": godot_icon,
      "description": "Guards ... 3\nTargets ... 1",
      "value": preload("res://scenes/test_map.tscn")
      },
} 

# ---- # map variables # ---- #
var map

# ---- # group variables # ---- #
var guards : Array
var targets : Array
var characterbodies : Array
var walls : Array
var windows : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

# ---- # Instance Guard # ---------------------------------------------------- #
# ---- # creates a guard at the given position with the given rotation and path 
func instance_guard(guard_route: Array, guard_rotation: int, weapon: PackedScene):
   print("Global: instancing guard at ", guard_route[0])
   var guard := guard_scene.instantiate()
   guard.position = guard_route[0]
   guard.rotation += deg_to_rad(guard_rotation);
   if guard_route.size() > 0: print("global: adding guard route")
   if weapon:
      var weapon_instance = weapon.instantiate()
      guard.add_child(weapon_instance)
      guard.weapon = weapon_instance
   guard.add_to_group("Guards")
   map.add_child(guard)

# ---- # Instance Target # --------------------------------------------------- #
# ---- # creates a target at the given position with the given rotation and path 
func instance_target(target_route: Array, target_rotation: int, weapon: PackedScene):
   print("Global: instancing target at ", target_route[0])
   var target := target_scene.instantiate()
   target.position = target_route[0]
   target.rotation += deg_to_rad(target_rotation);
   if target_route.size() > 0: print("global: adding target route")
   if weapon:
      var weapon_instance = weapon.instantiate()
      target.add_child(weapon_instance)
      target.weapon = weapon_instance
   target.add_to_group("Targets")
   map.add_child(target)

# ---- # Change Map # -------------------------------------------------------- #
# ---- # loads a new map # --------------------------------------------------- #
func change_map(map: PackedScene):
   print("Global: loading map")
   get_tree().change_scene_to_packed(map)

# ---- # Update Groups # ----------------------------------------------------- #
# ---- # gets the groups from the scene tree and updates the group variables # #
func update_groups():
   guards = get_tree().get_nodes_in_group("Guards")
   targets = get_tree().get_nodes_in_group("Targets")
   characterbodies = get_tree().get_nodes_in_group("CharacterBodies")
   walls = get_tree().get_nodes_in_group("Walls")
   windows = get_tree().get_nodes_in_group("Windows")

# ---- # Game Over # --------------------------------------------------------- #
# ---- # ends the game and determines the players score # -------------------- # 
func game_over(player_died: bool):
   if player_died:
      print("Global: player has lost")
      map.queue_free()
      return
   
   var guards_killed = guards.size()
   for guard in guards:
      if guard.status != "dead":
         guards_killed -= 1
   var targets_killed = targets.size()
   for target in targets:
      if target.status != "dead":
         targets_killed -= 1
   var score = (guards_killed * 0.5) + (targets_killed * 1.5)
      
   if player_died or targets_killed < targets.size(): print("Global: player has lost\nfinal score: ", score)
   else: print("Global: player has lost\nfinal score: ", score)
   show_perks = true
   get_tree().change_scene_to_packed(card_select)

# ---- # Save Game # --------------------------------------------------------- #
# ---- # saves all persistent game data # ------------------------------------ #
func save_game():
   print("Global: saving game")
   var save_file := FileAccess.open("user://savegame.save", FileAccess.WRITE)
   var save_nodes : Array = get_tree().get_nodes_in_group("Persist")
   
   for node in save_nodes:
      if node.scene_file_path.is_empty() or !node.has_method("save"):
         print("Global: node missing or lacks save method")
         continue
      var node_data : Dictionary = node.save()
      var json_data : String = JSON.stringify(node_data)
      save_file.store_line(json_data)
      
# ---- # Load Game # --------------------------------------------------------- #
# ---- # loads all persistent game data # ------------------------------------ #
func load_game():
   print("Global: loading save")
   if not FileAccess.file_exists("user://savegame.save"):
      print("Global: no save file")
      return
   
   var save_nodes : Array = get_tree().get_nodes_in_group("Persist")
   for node in save_nodes: node.queue_free()
   
   var save_file := FileAccess.open("user://savegame.save", FileAccess.WRITE)
   while save_file.get_position() < save_file.get_length():
      var json_data : String = save_file.get_line()
      var json : JSON = JSON.new()      # json helper class
      
      var parse_result := json.parse(json_data)
      var node_data = json.data
      
      var new_object = load(node_data["filename"]).instantiate()
      get_node(node_data["parent"]).add_child(new_object)
      new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
      
      # Now we set the remaining variables.
      for i in node_data.keys():
         if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
            continue
            new_object.set(i, node_data[i])
