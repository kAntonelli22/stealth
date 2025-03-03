extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   print_rich("[color=#64649E]entrance[/color]: emitting new entrance signal")
   Signals.emit_signal("new_entrance", self) # register self with ui


func _on_map_button_pressed() -> void:
   print_rich("[color=#64649E]entrance[/color]: selected")
   pass
   # tell ui that you were selected
