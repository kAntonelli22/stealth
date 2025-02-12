extends Node2D
class_name Exit

# ---- # nodes
@onready var exit_area := $ExitArea
@onready var area_collider := $ExitArea/AreaCollider
@onready var exit_timer := $ExitTimer
@onready var color := $Polygon2D

# ---- # arrays
var objects_in_area : Array = []

# ---- # variables
var exiting_object : Node2D

# ---- # Ready
func _ready() -> void:
   pass # Replace with function body.

# ---- # Exit Area Entered
func _on_exit_area_entered(body: Node2D) -> void:
   print("exit: body ", body, " entered")
   if body.type == "Player" or body.type == "Target":
      exit_timer.start()
      exiting_object = body
      objects_in_area.append(body)

# ---- # Exit Area Exited
func _on_exit_area_exited(body: Node2D) -> void:
   print("exit: body ", body, " exited")
   if body == exiting_object:
      exit_timer.stop()
      objects_in_area.remove_at(objects_in_area.find(body))

# ---- # Exit Timer Timeout
func _on_exit_timer_timeout() -> void:
   print("exit: body ", exiting_object, " left game")
   exiting_object.exit()
