extends Button


var entrance: Node2D


func _ready() -> void:
   pass # Replace with function body.

func _process(_delta: float) -> void:
   pass

func _on_pressed() -> void:
   print("entrance selected")
   Signals.emit_signal("entrance_selected")
