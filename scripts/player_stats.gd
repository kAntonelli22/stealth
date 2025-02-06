extends Resource
class_name PlayerStats

# ---- player stats # ---- #
@export_group("Player Stats")
@export var health : int         # 0 - 100
@export var health_regen : int   # placeholder
@export var speed : float          # 300.0
@export var stamina : float        # 0 - 100
@export var stamina_regen : float  # 0 - 2
@export var dash_distance : int  # distance that is added to velocity when dashing
@export var dash_cost : int      # amount subtracted from stamina when dashing

# ---- player economy # ---- #
@export_group("Player Economy")
@export var money : int

# ---- # player perks # ---- #
var perks : Array


# Called when the node enters the scene tree for the first time.
func _init(health: int = 100, health_regen: int = 1, speed: float = 300, stamina: int = 100, 
stamina_regen: int = 0.5, dash_dist: int = 75, dash_cost: int = 10, perks: Array = []) -> void:
   self.health = health
   self.health_regen = health_regen
   self.speed = speed
   self.stamina = stamina
   self.stamina_regen = stamina_regen
   self.dash_distance = dash_distance
   self.dash_cost = dash_cost
   self.perks = perks

func update_stats(health: int, health_regen: int, speed: float, stamina: int, 
stamina_regen: int, dash_dist: int, dash_cost: int, perks: Array) -> void:
   self.health = health
   self.health_regen = health_regen
   self.speed = speed
   self.stamina = stamina
   self.stamina_regen = stamina_regen
   self.dash_distance = dash_distance
   self.dash_cost = dash_cost
   self.perks = perks

func add_perk(perk): perks.append(perk)

func remove_perk(perk): perks.remove_at(perks.find(perk))

func remove_perk_at(index: int): perks.remove_at(index)
