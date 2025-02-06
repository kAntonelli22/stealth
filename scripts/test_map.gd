extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Global.games_played += 1
   Global.map = self
   Global.instance_guard([Vector2(200, 200)], 90, Global.melee)
   Global.instance_guard([Vector2(600, 400)], 180, Global.melee)
   Global.instance_target([Vector2(400, 400)], 180, Global.melee)
   Global.update_groups()
   Signals.emit_signal("map_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
   pass

# ---- # Issue List # -------------------------------------------------------- #
# - guard does not continue rotating to the players last know location
# - card carousel code is bad and map structure needs to be changed to fit perk structure
# - player cannot apply perks or even see them

# ---- # Issue List # -------------------------------------------------------- #

# ---- # Todo List # --------------------------------------------------------- #
# - player perk system
# - add save functions to all persistant objects
# - create light and dark mode themes
# - add lives and loss debuffs
# - add game over
# - add global groups
# - change guard sprite to show death
# - add player shadow in guard scenes for chasing unseen players
# - add guard paths
# - add guard pathfinding
# - add weapon parent class
# - add ranged weapons
# - guard vision cones expand when alerted
# - weapon sprites and animations
# - entry points
# - guard reinforce and vip exit points
# - dash increases detection

# ---- # Todo List # --------------------------------------------------------- #
# ---- # Game Info # --------------------------------------------------------- #
# - Grayscale light - dark
# - (#F8F9FA, #E9ECEF, #DEE2E6, #CED4DA, #ADB5BD, #6C757D, #495057, #343A40, #212529)
# - Blues light - dark
# - (#4E4EB5, #64649E, #474794, #29294D)
# - Reds light - dark
# - (#B54E4E, #A84A4A, #1C0F0F)

# ---- # Game Info # --------------------------------------------------------- #
