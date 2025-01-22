extends Node2D

# scenes
var guard_scene := preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   instance_guard(Vector2(100, 100), 90)
   instance_guard(Vector2(200, 200), 180)
   pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

func instance_guard(guard_position : Vector2, guard_rotation : int):
   print("map: instancing guard at ", guard_position)
   var guard := guard_scene.instantiate()
   guard.position = guard_position
   guard.rotation += deg_to_rad(guard_rotation)
   add_child(guard)
