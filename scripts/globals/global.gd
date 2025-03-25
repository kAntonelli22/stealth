extends Node


# ---- # save game stuff
var save: bool = true
var rounds: int = 0

# ---- # resources
var player_stats := preload("res://resources/player_stats.tres")

# ---- # assets
var godot_icon := preload("res://icon.svg")

# ---- # scenes
var card_select := load("res://scenes/ui_scenes/card_carousel.tscn")    # HACK if card select and shop are preload it causes cyclical reference
var card := preload("res://scenes/ui_scenes/card.tscn")
var entrance_ui := preload("res://scenes/ui_scenes/entrance_ui.tscn")
var shop := load("res://scenes/ui_scenes/shop.tscn")

var player_scene := preload("res://scenes/player.tscn")
var guard_scene := preload("res://scenes/enemy_scenes/guard.tscn")
var target_scene := preload("res://scenes/enemy_scenes/target.tscn")

var entrance_scene := preload("res://scenes/entrance.tscn")
var exit_scene := preload("res://scenes/exit.tscn")

var melee := preload("res://scenes/melee.tscn")

# ---- # card variables
var show_perks : bool = false    # used by card carousel to determine if perks should be offered

var contracts = {
   "contract": Contract,
}
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
var current_contract: Contract

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

# ---- # Change Scene
func change_scene(new_scene: PackedScene):
   get_tree().change_scene_to_packed(new_scene)

# ---- # Start Contract
func start_contract(new_contract: Contract):
   print_rich("[color=64649E][b]Starting Contract[/b][/color]")
   current_contract = new_contract
   change_scene(new_contract.map)

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
# TODO change calculation of money modifier
func contract_over(player_died: bool):
   
   var guards_killed: float = current_contract.guards
   for guard in guards:
      if guard.state == guard.states["dead"]:
         guards_killed -= 1
   var targets_killed: float = current_contract.targets
   for target in targets:
      if target.state == target.states["dead"]:
         targets_killed -= 1
   var target_mod: float = (targets_killed / current_contract.targets) * 4
   var guard_mod: float = (guards_killed / current_contract.guards) * 2
   var time_mod = 1#(start_time - end_time) * 1
   
   var payout = current_contract.payout * target_mod * guard_mod * time_mod
      
   if player_died or targets_killed < targets.size():
      print_rich("[color=Crimson]Player has lost[/color]\n
      target modifier: ", target_mod, "\nguard modifier: ", guard_mod,
      "\ntime modifier: ", time_mod)
   else:
      print_rich("[color=Royalblue]Player has won[/color]\n
      target modifier: ", target_mod, "\nguard modifier: ", guard_mod,
      "\ntime modifier: ", time_mod, "\ncontract payout")
      player_stats.money += round(payout)
   show_perks = true
   current_contract = null
   rounds += 1
   change_scene(card_select)
