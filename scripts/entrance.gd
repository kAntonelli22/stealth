extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass
   #Signals.emit("new_entrance", self) # register self with ui

func _on_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
   if event.is_action_pressed("attack"):
      pass
      # set selected entrance to this entrance
