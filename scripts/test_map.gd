extends Node2D

# ---- # Ready
func _ready() -> void:
   Global.games_played += 1
   Global.map = self
   
   var entity_dict: Dictionary = {"position": Vector2(100, 100), "rotation": deg_to_rad(90)}
   Global.entity_factory(Global.player_scene, entity_dict, Melee)
   
   entity_dict = {"path_route": [Vector2(200, 200), Vector2(800, 200)], "rotation": 0}
   Global.entity_factory(Global.guard_scene, entity_dict, Melee, "Guards")
   
   entity_dict.path_route = [Vector2(600, 400)]
   Global.entity_factory(Global.guard_scene, entity_dict, Melee, "Guards")
   
   entity_dict.path_route = [Vector2(400, 425)]
   entity_dict.rotation = deg_to_rad(90)
   Global.entity_factory(Global.target_scene, entity_dict, Melee, "Guards")
   
   Global.instance_entrance(Vector2(50, 50))
   Global.instance_entrance(Vector2(50, 150))
   get_node("Camera").adjust_camera($Player, -15, -300, 663, 1167)
   Signals.emit_signal("map_changed")

# ---- # Process
func _process(_delta: float) -> void:
   pass

# ---- # Issue List # -------------------------------------------------------- #
# - enemy get transition function does not work as intended
# - guards instantly begin chasing player after detecting them once
# - load runs into issues with enemy ready code
# - ai restarts at route point one on load
# - ai gets stuck on corners
# - ai can backstab and damage eachother
# - change hard coded string paths to resource uids

# ---- # Issue List # -------------------------------------------------------- #
# ---- # Todo List # --------------------------------------------------------- #
# - generic map scene that all maps are created out of or inherit from
# - enemy hunt state that transitions to idle
# - enemy backpedal state. move away once past weapon effective range
# - fully implement guard death and score calculation along with player economics
# - detection overhaul (dashing and distance factored in, noise areas, detection shadow)
# - create light and dark mode themes
# - add game over, lives, debuffs for losing
# - deployment, reinforcements
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
