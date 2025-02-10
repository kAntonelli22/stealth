extends Enemy


func _ready() -> void:
   type = "Target"
   status = "normal"
   super()
   
func _physics_process(delta: float) -> void:
# ---- # loops through all spotted objects and determines what to do # ---- #
   for object in spotted_objects:
      if object.type == "Player":      # engage the player
         player = object
         if threat_detected: nav_agent.target_position = object.position
         if status != "engaging": status == "engaging"
      elif object.type == "Guard":
         #print("guard: guard spotted")
         if object.status == "alert": status = "alert"
         elif object.status == "engaging":
            status = "engaging"
            nav_agent.target_position = object.nav_agent.target_position
         elif object.status == "dead": status = "alert"
   # ---- # end of for loop # ------------------------------------------------ #
   super(delta)
      
func exit():
   print("target: exiting scene")
