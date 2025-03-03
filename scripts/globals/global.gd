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
var entrance_ui := preload("res://scenes/ui_scenes/entrance_ui.tscn")

var player_scene := preload("res://scenes/player.tscn")
var guard_scene := preload("res://scenes/enemy_scenes/guard.tscn")
var target_scene := preload("res://scenes/enemy_scenes/target.tscn")

var entrance_scene := preload("res://scenes/entrance.tscn")
var exit_scene := preload("res://scenes/exit.tscn")

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
var entrances : Array
var exits : Array
var persist : Array  # contains all currently loaded nodes that must be saved

func _ready() -> void:
   Signals.connect("map_changed", update_groups)
   Signals.connect("contract_over", contract_over)

# ---- # Entity Factory
# creates a new entity and loads the provided data
func entity_factory(scene, entity_data: Dictionary, weapon, group: String = ""):
   print_rich("[color=64649E]Entity Factory[/color]: ")
   var entity = scene.instantiate()
   print_rich("\tcreating a new ", entity.name, " with the data ", entity_data)
   for i in entity_data.keys():
      print_rich("\tsetting key ", i, " with ", entity_data[i])
      if i == "path_route":
         var array: Array[Vector2]
         array.assign(entity_data[i])
         entity.path_route = array
      else:
         entity.set(i, entity_data[i])
   
   if group != "": entity.add_to_group(group)
   entity.add_to_group("Persist")
   map.add_child(entity)
   if weapon: weapon.equip(entity)

# ---- # Instance Entrance
func instance_entrance(position):
   var entrance = entrance_scene.instantiate()
   entrance.position = position
   map.add_child(entrance)

func instance_exit(position):
   var exit = exit_scene.instantiate()
   exit.position = position
   map.add_child(exit)

# ---- # Change Map
func change_map(new_map: PackedScene):
   print_rich("[color=64649E][b]Changing Map[/b][/color]: ")
   get_tree().change_scene_to_packed(new_map)

# ---- # Update Groups
# updates global group variables
func update_groups():
   guards = get_tree().get_nodes_in_group("Guards")
   targets = get_tree().get_nodes_in_group("Targets")
   characterbodies = get_tree().get_nodes_in_group("CharacterBodies")
   walls = get_tree().get_nodes_in_group("Walls")
   windows = get_tree().get_nodes_in_group("Windows")
   entrances = get_tree().get_nodes_in_group("Entrances")
   exits = get_tree().get_nodes_in_group("Exits")

# ---- # Game Over
# ends the game and determines the players score before scene transition
func contract_over(player_died: bool):
   if player_died:
      get_tree().change_scene_to_packed(card_select)
      return
   
   var guards_killed = guards.size()
   #for guard in guards:
      #if guard.status != "dead":
         #guards_killed -= 1
   var targets_killed = targets.size()
   #for target in targets:
      #if target.status != "dead":
         #targets_killed -= 1
   var score = (guards_killed * 0.5) + (targets_killed * 1.5)
      
   if player_died or targets_killed < targets.size():
      print_rich("[color=Crimson]Player has lost[/color]\nfinal score: ", score)
   else:
      print_rich("[color=Royalblue]Player has won[/color]\nfinal score: ", score)
   show_perks = true
   get_tree().change_scene_to_packed(card_select)
