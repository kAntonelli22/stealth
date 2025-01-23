extends CharacterBody2D

# physics variables
const SPEED = 200.0
const ROTATE_SPEED = 2.0
var move_target : Vector2 = Vector2(-1, -1)

# logic variables
var type : String = "Guard"
var status : String = "normal"      # normal | alert | engaging | dead
var alert : bool = false

# sight variables
var spotted_objects : Array = []

#
@onready var map = get_parent()
@onready var player = map.player

func _physics_process(delta: float) -> void:
   for object in spotted_objects:
      if object.type == "Player":      # engage the player
         move_target = object.position
         if status != "engaging": status == "engaging"
      elif object.type == "Guard":
         #print("guard: guard spotted")
         if object.status == "alert": status = "alert"
         elif object.status == "engaging":
            status = "engaging"
            move_target = object.move_target
         elif object.status == "dead": status = "alert"
   # --- # end of for loop # ------------------------------------------------- #
   if move_target != position and move_target != Vector2(-1, -1):
      print("guard: moving to: ", move_target)
      position = position.move_toward(move_target, delta * SPEED)
      var angle_to := position.angle_to_point(player.position) + deg_to_rad(90)
      rotation = move_toward(rotation, angle_to, delta * ROTATE_SPEED)
   move_and_slide()

func _on_vision_cone_entered(body: Node2D) -> void:
   print("guard: vision cone entered by: ", body.name)
   if body != self: spotted_objects.append(body)

func _on_vision_cone_exited(body: Node2D) -> void:
   print("guard: vision cone exited: ", body.name)
   spotted_objects.remove_at(spotted_objects.find(body))
