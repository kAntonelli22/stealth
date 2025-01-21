extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
   pass

func _on_vision_cone_entered(body: Node2D) -> void:
   print("cpu: vision cone entered by: ", body.name)
   pass # Replace with function body.

func _on_vision_cone_exited(body: Node2D) -> void:
   print("cpu: vision cone exited: ", body.name)
   pass # Replace with function body.
