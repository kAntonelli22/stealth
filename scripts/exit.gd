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
var waiting_for_input : bool = false

# ---- # Ready
func _ready() -> void:
   add_to_group("Exits")

# ---- # Process
func _input(event):
   if !waiting_for_input: return
   if event.is_action_pressed("interact"): exiting_object.exit()

# ---- # Exit Area Entered
func _on_exit_area_entered(body: Node2D) -> void:
   print("exit: body ", body, " entered")
   if body is Player or body is Target:
      exit_timer.start()
      exiting_object = body
      objects_in_area.append(body)

# ---- # Exit Area Exited
func _on_exit_area_exited(body: Node2D) -> void:
   print("[color=#64649E]exit[/color]: body ", body, " exited")
   if body == exiting_object:
      exit_timer.stop()
      objects_in_area.remove_at(objects_in_area.find(body))

# ---- # Exit Timer Timeout
func _on_exit_timer_timeout() -> void:
   print("[color=#64649E]exit[/color]: body ", exiting_object, " left game")
   if exiting_object is Target: exiting_object.exit_map()
   if exiting_object is Player: waiting_for_input = true
