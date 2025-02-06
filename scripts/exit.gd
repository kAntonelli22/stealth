extends Node2D
class_name Exit

# ---- # Nodes # ---- #
@onready var exit_area := $ExitArea
@onready var area_collider := $ExitArea/AreaCollider
@onready var exit_timer := $ExitTimer
@onready var color := $Polygon2D

# ---- # Arrays # ---- #
var objects_in_area : Array = []

# ---- # Variables # ---- #
var exiting_object : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass # Replace with function body.


func _on_exit_area_entered(body: Node2D) -> void:
   print("exit: body ", body, " entered")
   if body.type == "Player" or body.type == "Target":
      exit_timer.start()
      exiting_object = body
      objects_in_area.append(body)


func _on_exit_area_exited(body: Node2D) -> void:
   print("exit: body ", body, " exited")
   if body == exiting_object:
      exit_timer.stop()
      objects_in_area.remove_at(objects_in_area.find(body))


func _on_exit_timer_timeout() -> void:
   print("exit: body ", exiting_object, " left game")
   exiting_object.exit()
