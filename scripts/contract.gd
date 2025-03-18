extends Resource
class_name Contract

# TODO create a way to randomly generate contracts

# ---- # Variables
var map: PackedScene
var payout: int
var targets: int
var guards: int
var time_limit: int

# ---- # Card
var name: String
var texture: Texture2D
var description: String

func _init(
   p_map: PackedScene = Global.maps["map1"].value, 
   p_payout: int = 100, 
   p_targets: int = 1, 
   p_guards: int = 2, 
   p_time_limit: int = 9999,
   p_name: String = "Contract",
   p_texture: Texture2D = Global.godot_icon,
   p_description: String = 
   "guards ... " + str(p_guards)
   + "\ntargets ... " + str(p_targets)
   + "\ntime limit ... "+ str(p_time_limit)
   + "\npayout ... " + str(p_payout),
   ):
   map = p_map
   payout = p_payout
   targets = p_targets
   guards = p_guards
   time_limit = p_time_limit
   name = p_name
   texture = p_texture
   description = p_description
