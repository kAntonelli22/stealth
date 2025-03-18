extends Resource
class_name PlayerStats
# TODO implement player inventory system

# ---- player stats
@export_group("Player Stats")
@export var health: int          # 0 - 100
@export var health_regen: int    # placeholder
@export var speed: float         # 300.0
@export var stamina: float       # 0 - 100
@export var stamina_regen: float # 0 - 2
@export var dash_speed: int      # distance that is added to velocity when dashing
@export var dash_cost: int       # amount subtracted from stamina when dashing

# ---- player economy
@export_group("Player Economy")
@export var money: int           # holds the players money

# ---- # player perks and inventory
@export_group("Player Perk & Inventory Stats")
@export var max_perks: int          # max number of perks the player can hold
@export var inventory_slots: int
var perks: Array
var inventory: Array

# ---- # Player Stats Initializer
func _init(
   p_health: int = 100,
   p_health_regen: int = 1,
   p_speed: float = 300,
   p_stamina: int = 100, 
   p_stamina_regen: float = 0.5,
   p_dash_speed: int = 75,
   p_dash_cost: int = 10,
   p_money: int = 30,
   p_perks: Array = [],
   p_inventory: Array = []
   ) -> void:
   health = p_health
   health_regen = p_health_regen
   speed = p_speed
   stamina = p_stamina
   stamina_regen = p_stamina_regen
   dash_speed = p_dash_speed
   dash_cost = p_dash_cost
   money = p_money
   perks = p_perks
   inventory = inventory

# ---- # Update Stats
# used to update the players stats resource --- i dont think this is in use
func update_stats(
   p_health: int,
   p_health_regen: int,
   p_speed: float,
   p_stamina: int,
   p_stamina_regen: int, 
   p_dash_speed: int,
   p_dash_cost: int,
   p_money: int,
   p_perks: Array,
   p_inventory: Array
   ) -> void:
   health = p_health
   health_regen = p_health_regen
   speed = p_speed
   stamina = p_stamina
   stamina_regen = p_stamina_regen
   dash_speed = p_dash_speed
   dash_cost = p_dash_cost
   money = p_money
   perks = p_perks
   inventory = inventory

# ---- # Add Perk
func add_perk(perk): perks.append(perk)
# ---- # Remove Perk
func remove_perk(perk): perks.remove_at(perks.find(perk))
# ---- # Remove Perk At
func remove_perk_at(index: int): perks.remove_at(index)

# ---- # Save
func save(array: Array[SavedData]):
   var saved_data = SavedPlayerData.new()
   saved_data.path = scene_file_path
   saved_data.parent = get_parent().get_path()
   saved_data.data = data
   array.append(saved_data)

# ---- # On Save Game
func before_load():
   get_parent().remove_child(self)
   queue_free()

# ---- # On Save Game
func after_load(saved_data: SavedData):
   var saved_card = saved_data as SavedCardData
   data = saved_card.data


# ---- # Save
func save() -> Dictionary:
   var perk_dict : Dictionary
   for perk in perks:
      perk_dict.get_or_add(perk, perk.save())
   var save_dict : Dictionary = {
      "type": "resource",
      "health": health,
      "health_regen": health_regen,
      "speed": speed,
      "stamina": stamina,
      "stamina_regen": stamina_regen,
      "dash_speed": dash_speed,
      "dash_cost": dash_cost,
      "money": money,
      "perks": perk_dict,
      "inventory": inventory,
   }
   return save_dict
