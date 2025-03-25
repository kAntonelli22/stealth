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
@export var perks: Array[Perk]
@export var inventory: Array

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
   p_perks: Array[Perk] = [],
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
   inventory = p_inventory

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
   inventory = p_inventory

# ---- # Add Perk
func add_perk(perk): perks.append(perk)
# ---- # Remove Perk
func remove_perk(perk): perks.remove_at(perks.find(perk))
# ---- # Remove Perk At
func remove_perk_at(index: int): perks.remove_at(index)

# ---- # Save
func save(array: Array[SavedData]):
   var saved_data = SavedPlayerData.new()
   saved_data.health = health
   saved_data.health_regen = health_regen
   saved_data.speed = speed
   saved_data.stamina = stamina
   saved_data.stamina_regen = stamina_regen
   saved_data.dash_speed = dash_speed
   saved_data.dash_cost = dash_cost
   saved_data.money = money
   saved_data.perks = perks
   saved_data.inventory = inventory
   array.append(saved_data)
   print_rich("[color=Royalblue]Player Stats[/color]: saving, perks ", saved_data.perks)

# ---- # After Load Game
func after_load(saved_data: SavedData):
   var saved_stats = saved_data as SavedPlayerData
   print_rich("[color=Royalblue]Player Stats[/color]: loading, perks ", saved_stats.perks)
   health = saved_stats.health
   health_regen = saved_stats.health_regen
   speed = saved_stats.speed
   stamina = saved_stats.stamina
   stamina_regen = saved_stats.stamina_regen
   dash_speed = saved_stats.dash_speed
   dash_cost = saved_stats.dash_cost
   money = saved_stats.money
   perks = saved_stats.perks     # FIXME perks array is empty on load
   inventory = saved_stats.inventory
