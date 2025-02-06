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
@export_group("Player Perks")
@export var perks : Array


# Called when the node enters the scene tree for the first time.
func _init(hp: int = 100, hp_regen: int = 1, spd: float = 300, stamina: int = 100, 
stamina_regen: int = 0.5, dsh_dist: int = 75, dsh_cost: int = 10, prks: Array = []) -> void:
   health = hp
   health_regen = hp_regen
   speed = spd
   stamina = stamina
   stamina_regen = stamina_regen
   dash_distance = dsh_dist
   dash_cost = dsh_cost
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())
   add_perk(Perk.SpeedPerk.new())

func update_stats(hp: int, hp_regen: int, spd: float, stamina: int, 
stamina_regen: int, dsh_dist: int, dsh_cost: int, prks: Array) -> void:
   health = hp
   health_regen = hp_regen
   speed = spd
   stamina = stamina
   stamina_regen = stamina_regen
   dash_distance = dsh_dist
   dash_cost = dsh_cost

func add_perk(perk):
   print("appending perk: ", perk)
   perks.append(perk)
   print("perks: ", perks)

func remove_perk(perk):
   perks.remove_at(perks.find(perk))

func remove_perk_at(index: int):
   perks.remove_at(index)

func get_perks() -> Array: return perks
func get_perk(index: int) -> Array: return perks[index]
