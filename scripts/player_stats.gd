extends Resource
class_name PlayerStats

# ---- player stats
@export_group("Player Stats")
@export var health : int         # 0 - 100
@export var health_regen : int   # placeholder
@export var speed : float          # 300.0
@export var stamina : float        # 0 - 100
@export var stamina_regen : float  # 0 - 2
@export var dash_speed : int     # distance that is added to velocity when dashing
@export var dash_cost : int      # amount subtracted from stamina when dashing

# ---- player economy
@export_group("Player Economy")
@export var money : int

# ---- # player perks
var perks : Array

# ---- # Player Stats Initializer
func _init(p_health: int = 100, p_health_regen: int = 1, p_speed: float = 300, p_stamina: int = 100, 
p_stamina_regen: float = 0.5, p_dash_speed: int = 75, p_dash_cost: int = 10, p_perks: Array = []) -> void:
   health = p_health
   health_regen = p_health_regen
   speed = p_speed
   stamina = p_stamina
   stamina_regen = p_stamina_regen
   dash_speed = p_dash_speed
   dash_cost = p_dash_cost
   perks = p_perks

# ---- # Update Stats
# used to update the players stats resource --- i dont think this is in use
func update_stats(p_health: int, p_health_regen: int, p_speed: float, p_stamina: int, 
p_stamina_regen: int, p_dash_speed: int, p_dash_cost: int, p_perks: Array) -> void:
   health = p_health
   health_regen = p_health_regen
   speed = p_speed
   stamina = p_stamina
   stamina_regen = p_stamina_regen
   dash_speed = p_dash_speed
   dash_cost = p_dash_cost
   perks = p_perks

# ---- # Add Perk
func add_perk(perk): perks.append(perk)
# ---- # Remove Perk
func remove_perk(perk): perks.remove_at(perks.find(perk))
# ---- # Remove Perk At
func remove_perk_at(index: int): perks.remove_at(index)

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
      "perks": perk_dict,
   }
   return save_dict
