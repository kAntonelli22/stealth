extends Node2D

# ---- # Ready
func _ready() -> void:
   Global.games_played += 1
   Global.map = self
   Global.instance_player(Vector2(100, 100), 90, Melee)
   #Global.instance_guard([Vector2(200, 200), Vector2(800, 200)], 0, Melee)
   Global.instance_guard([Vector2(600, 450)], 0, Melee)
   #Global.instance_target([Vector2(400, 425)], 90, Melee)
   get_node("Camera").adjust_camera($Player, -15, -300, 663, 1167)
   Signals.emit_signal("map_changed")

# ---- # Process
func _process(_delta: float) -> void:
   pass

# ---- # Issue List # -------------------------------------------------------- #
# - card carousel code is bad
# - save code needs to be cleaned up
# - ai restarts at route point one on load
# - ai gets stuck on corners
# - ai can backstab and damage eachother
# - change hard coded string paths to resource uids

# ---- # Issue List # -------------------------------------------------------- #
# ---- # Todo List # --------------------------------------------------------- #
# - enemy hunt state that transitions to idle
# - enemy backpedal state. move away once past weapon effective range
# - guard death
# - detection overhaul (dashing and distance factored in, noise areas, detection shadow)
# - create light and dark mode themes
# - add game over, lives, debuffs for losing
# - entry points, deployment, exit points, reinforcements
# - action key circular loading symbol for exits
# - player movement overhaul (actual dash)
# - weapon overhaul (ranged parent class, default weapons, equip code, drop code, sprites)
# - combat overhaul (body parts, damage debuffs)

# ---- # Todo List # --------------------------------------------------------- #
# ---- # Game Info # --------------------------------------------------------- #
# - player size 16x16
# - Grayscale light - dark
# - (#F8F9FA, #E9ECEF, #DEE2E6, #CED4DA, #ADB5BD, #6C757D, #495057, #343A40, #212529)
# - Blues light - dark
# - (#4E4EB5, #64649E, #474794, #29294D)
# - Reds light - dark
# - (#B54E4E, #A84A4A, #1C0F0F)

# ---- # Game Info # --------------------------------------------------------- #
