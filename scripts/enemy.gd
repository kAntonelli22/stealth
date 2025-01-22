extends CharacterBody2D


const SPEED = 200.0
var alert : bool = false
var target_sighted : bool = false
var target : Node2D
var target_position : Vector2

func _physics_process(delta: float) -> void:
   if target and target_sighted:
      position = position.move_toward(target.position, delta * SPEED)
   elif target and !target_sighted:
      position = position.move_toward(target_position, delta * SPEED)
   
   move_and_slide()

func _on_vision_cone_entered(body: Node2D) -> void:
   print("cpu: vision cone entered by: ", body.name)
   target = body
   target_sighted = true

func _on_vision_cone_exited(body: Node2D) -> void:
   print("cpu: vision cone exited: ", body.name)
   target_position = target.position
   target_sighted = true
