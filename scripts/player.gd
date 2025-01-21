extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
   # get the direction the player is moving as a vector2
   var direction : Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
   if direction.x: velocity.x = direction.x * SPEED
   else: velocity.x = move_toward(velocity.x, 0, SPEED)
      
   if direction.y: velocity.y = direction.y * SPEED
   else: velocity.y = move_toward(velocity.y, 0, SPEED)

   move_and_slide()
