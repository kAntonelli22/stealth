extends Enemy
class_name Guard

func _ready() -> void:
   type = "Guard"
   status = "normal"

func _physics_process(delta: float) -> void:
   # ---- # loops through all spotted objects and determines what to do # ---- #
   var player : CharacterBody2D
   for object in spotted_objects:
      if object.type == "Player":      # engage the player
         player = object
         if threat_detected: move_target = object.position
         if status != "engaging": status == "engaging"
      elif object.type == "Guard":
         if object.status == "alert": status = "alert"
         elif object.status == "engaging":
            status = "engaging"
            move_target = object.move_target
         elif object.status == "dead": status = "alert"
   # ---- # end of for loop # ------------------------------------------------ #
   if player and detection < 100: detection += 1
   if detection == 100: threat_detected = true
   ai_attack(player)
   super(delta)
