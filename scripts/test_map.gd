extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Global.map = self
   Global.instance_guard([Vector2(200, 200)], 90, Global.melee)
   Global.instance_guard([Vector2(600, 400)], 180, Global.melee)
   Global.instance_target([Vector2(400, 400)], 180, Global.melee)
   Global.update_groups()
   Signals.emit_signal("map_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

# ---- # Issue List # -------------------------------------------------------- #
# - guard does not continue rotating to the players last know location

# ---- # Issue List # -------------------------------------------------------- #

# ---- # Todo List # --------------------------------------------------------- #
# - add game over
# - add global groups
# - change guard sprite to show death
# - add player shadow in guard scenes for chasing unseen players
# - add guard paths
# - add guard pathfinding
# - add guard weapons (knife, batton, pistol, shotgun, smg, rifle)
# - add player weapons (fists, knife, sword, pistol)
# - guard vision cones expand when alerted
# - weapon sprites and animations
# - entry and exit points
# - guard reinforce and vip exit points
# - dash increases detection
# - player perks

# ---- # Todo List # --------------------------------------------------------- #
# ---- # Game Info # --------------------------------------------------------- #
# - Grayscale light - dark
# - (#F8F9FA, #E9ECEF, #DEE2E6, #CED4DA, #ADB5BD, #6C757D, #495057, #343A40, #212529)
# - Blues light - dark
# - (#4E4EB5, #64649E, #474794, #29294D)
# - Reds light - dark
# - (#B54E4E, #A84A4A, #1C0F0F)

# ---- # Game Info # --------------------------------------------------------- #
