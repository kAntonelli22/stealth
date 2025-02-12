extends Enemy

# ---- # Ready
func _ready() -> void:
   type = "Target"
   status = "normal"
   super()

# ---- # Physics Process
func _physics_process(delta: float) -> void:
   for object in spotted_objects:
      if object.type == "Player":      # engage the player
         player = object
         if threat_detected: nav_agent.target_position = object.position
         if status != "engaging": status == "engaging"
      elif object.type == "Guard":
         if object.status == "alert": status = "alert"
         elif object.status == "engaging":
            status = "engaging"
            nav_agent.target_position = object.nav_agent.target_position
         elif object.status == "dead": status = "alert"
   # ---- # end of for loop # ------------------------------------------------ #
   if player and spotted_objects.find(player) == -1: player = null
   super(delta)

# ---- # Exit
func exit():
   print("target: exiting scene")
