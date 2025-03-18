extends Node2D

# ---- # Ready
func _ready() -> void:
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
   get_node("Camera").adjust_camera($Player, $Background)
   Signals.emit_signal("map_changed")

# ---- # Process
func _process(_delta: float) -> void:
   pass

# ---- # Issue List # -------------------------------------------------------- #
# FIXME camera does not take ui offset into account when centering on player
# FIXME vision cones cannot be changed mid game
# FIXME clicks on ui causes player to attack
# FIXME guards instantly begin chasing player after detecting them once
# FIXME load runs into issues with enemy ready code
# FIXME ai restarts at route point one on load
# FIXME ai gets stuck on corners
# FIXME ai can backstab and damage eachother
# FIXME change hard coded string paths to resource uids

# ---- # Issue List # -------------------------------------------------------- #
# ---- # Todo List # --------------------------------------------------------- #
# TODO inventory system
# TODO deployment screen with paused game
# TODO reinforcement signal that deploys more guards
# TODO generic map scene that all maps are created out of or inherit from
# TODO enemy hunt state that transitions to idle
# TODO enemy backpedal state. move away once past weapon effective range
# TODO fully implement guard death and score calculation along with player economics
# TODO detection overhaul (dashing and distance factored in, noise areas, detection shadow)
# TODO create light and dark mode themes
# TODO add game over, lives, debuffs for losing
# TODO action key circular loading symbol for exits
# TODO player movement overhaul (actual dash)
# TODO weapon overhaul (ranged parent class, default weapons, equip code, drop code, sprites)
# TODO combat overhaul (body parts, damage debuffs)

# ---- # Todo List # --------------------------------------------------------- #
# ---- # Game Info # --------------------------------------------------------- #
# - player size 16x16
# - Grayscale dark - light
# - (#15151A, #292933, #3E3E4D, #A3A3CC, #B8B8E6, #CCCCFF)

# - Blues light - dark
# - (#4E4EB5, #64649E, #474794, #29294D)
# - Reds light - dark
# - (#B54E4E, #A84A4A, #1C0F0F)

# ---- # Game Info # --------------------------------------------------------- #
