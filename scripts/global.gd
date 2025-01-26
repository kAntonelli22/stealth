extends Node

# ---- # scenes # ---- #
var guard_scene := preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

# ---- # Instance Guard # ---------------------------------------------------- #
# ---- # creates a guard at the given position with the given rotation and path 
func instance_guard(map : Node2D, guard_route : Array, guard_rotation : int):
   print("map: instancing guard at ", guard_route[0])
   var guard := guard_scene.instantiate()
   guard.position = guard_route[0]
   guard.rotation += deg_to_rad(guard_rotation);
   if guard_route.size() > 0: print("global: adding guard route")
   map.add_child(guard)
