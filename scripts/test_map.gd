extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Global.games_played += 1
   Global.map = self
   Global.instance_guard([Vector2(200, 200)], 90, Global.melee)
   Global.instance_guard([Vector2(600, 450)], 90, Global.melee)
   Global.instance_target([Vector2(400, 425)], 180, Global.melee)
   get_node("Camera").adjust_camera($Player, -15, -15, 663, 1167)
   Signals.emit_signal("map_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
   pass

# ---- # Issue List # -------------------------------------------------------- #
# - card carousel code is bad
# - save code needs to be cleaned up
# - ai can backstab and damage eachother
# - change hard coded string paths to resource uids

# ---- # Issue List # -------------------------------------------------------- #

# ---- # Todo List # --------------------------------------------------------- #
# - create light and dark mode themes
# - add game over, lives, debuffs for losing
# - detection overhaul (dashing and distance factored in, noise areas)
# - entry points, deployment, exit points, reinforcements
# - player movement overhaul (actual dash)
# - weapon overhaul (ranged parent class, default weapons, equip code, drop code, sprites)
# - guard overhaul (patrol routes, pathfinding, detection shadow, death)
# - combat overhaul (body parts, damage debuffs)

# ---- # Todo List # --------------------------------------------------------- #
# ---- # Game Info # --------------------------------------------------------- #
# - Grayscale light - dark
# - (#F8F9FA, #E9ECEF, #DEE2E6, #CED4DA, #ADB5BD, #6C757D, #495057, #343A40, #212529)
# - Blues light - dark
# - (#4E4EB5, #64649E, #474794, #29294D)
# - Reds light - dark
# - (#B54E4E, #A84A4A, #1C0F0F)

# ---- # Game Info # --------------------------------------------------------- #
