extends Node


# ---- # save game stuff
var save_game_placeholder : bool = true
var games_played : int = 0

# ---- # resources
var player_stats := preload("res://resources/player_stats.tres")
var perk := preload("res://resources/perk.tres")

# ---- # assets
var godot_icon := preload("res://icon.svg")

# ---- # scenes
var card_select := preload("res://scenes/ui_scenes/card_carousel.tscn")
var card := preload("res://scenes/ui_scenes/card.tscn")

var player_scene := preload("res://scenes/player.tscn")
var guard_scene := preload("res://scenes/enemy_scenes/guard.tscn")
var target_scene := preload("res://scenes/enemy_scenes/target.tscn")

var melee := preload("res://scenes/melee.tscn")

# ---- # card variables
var show_perks : bool = false    # used by card carousel to determine if perks should be offered

var maps = {
   "map1": {
      "name": "Map 1",
      "image": godot_icon,
      "description": "Guards ... 3\nTargets ... 1",
      "value": preload("res://scenes/test_map.tscn")
      },
   "map2": {
      "name": "Map 1",
      "image": godot_icon,
      "description": "Guards ... 3\nTargets ... 1",
      "value": preload("res://scenes/test_map.tscn")
      },
   "map3": {
      "name": "Map 1",
      "image": godot_icon,
      "description": "Guards ... 3\nTargets ... 1",
      "value": preload("res://scenes/test_map.tscn")
      },
} 

# ---- # map variables
var map

# ---- # group variables
var guards : Array
var targets : Array
var characterbodies : Array
var walls : Array
var windows : Array
var persist : Array  # contains all currently loaded nodes that must be saved

func _ready() -> void:
   Signals.connect("map_changed", update_groups)
   Signals.connect("contract_over", contract_over)

# ---- # Enemy Factory
# creates a new enemy for the map calling it and adds default values

#func enemy_factory(position: Vector2, rotation: float, weapon):
   #var enemy := player_scene.instantiate()
   #guard.path_route = guard_route
   #guard.rotation += deg_to_rad(guard_rotation)
   #guard.position = guard.next_route_position()
   #guard.add_to_group("Guards")
   #guard.add_to_group("Persist")
   #map.add_child(guard)
   #if weapon: weapon.equip(guard)
   
# ---- # Instance Target
# creates a target at the given position with the given rotation and path 
func instance_player(position: Vector2, rotation: float, weapon):
   var player := player_scene.instantiate()
   player.rotation += deg_to_rad(rotation);
   player.position = position
   player.add_to_group("Persist")
   map.add_child(player)
   if weapon: weapon.equip(player)
   
# ---- # Instance Guard
# creates a guard at the given position with the given rotation and path 
func instance_guard(guard_route: Array[Vector2], guard_rotation: int, weapon):
   var guard := guard_scene.instantiate()
   guard.path_route = guard_route
   guard.rotation += deg_to_rad(guard_rotation)
   guard.position = guard.next_route_position()
   guard.add_to_group("Guards")
   guard.add_to_group("Persist")
   map.add_child(guard)
   if weapon: weapon.equip(guard)

# ---- # Instance Target
# creates a target at the given position with the given rotation and path 
func instance_target(target_route: Array[Vector2], target_rotation: int, weapon):
   var target := target_scene.instantiate()
   target.path_route = target_route
   target.rotation += deg_to_rad(target_rotation);
   target.position = target.next_route_position()
   target.add_to_group("Targets")
   target.add_to_group("Persist")
   map.add_child(target)
   if weapon: weapon.equip(target)

# ---- # Change Map
func change_map(new_map: PackedScene):
   print("Global: loading map")
   get_tree().change_scene_to_packed(new_map)

# ---- # Update Groups
# updates global group variables
func update_groups():
   guards = get_tree().get_nodes_in_group("Guards")
   targets = get_tree().get_nodes_in_group("Targets")
   characterbodies = get_tree().get_nodes_in_group("CharacterBodies")
   walls = get_tree().get_nodes_in_group("Walls")
   windows = get_tree().get_nodes_in_group("Windows")

# ---- # Game Over
# ends the game and determines the players score before scene transition
func contract_over(player_died: bool):
   if player_died:
      get_tree().change_scene_to_packed(card_select)
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
