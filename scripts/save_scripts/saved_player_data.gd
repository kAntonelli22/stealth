extends SavedData
class_name SavedPlayerData

# ---- player stats
@export var health: int          # 0 - 100
@export var health_regen: int    # placeholder
@export var speed: float         # 300.0
@export var stamina: float       # 0 - 100
@export var stamina_regen: float # 0 - 2
@export var dash_speed: int      # distance that is added to velocity when dashing
@export var dash_cost: int       # amount subtracted from stamina when dashing

# ---- player economy
@export var money: int           # holds the players money

# ---- # player perks and inventory
@export var max_perks: int          # max number of perks the player can hold
@export var inventory_slots: int
@export var perks: Array[Perk]
@export var inventory: Array
