extends Enemy
class_name Guard

# ---- # Ready
func _ready() -> void:
   super()
   add_state("chase")
   call_deferred("set_state", states.idle)

# ---- # State Logic
func _state_logic(delta):
   #for object in spotted_objects:
      #if object is Player: player = object
      #elif object is Guard:
         #if object.state == state.chase:
            #set_state("chase")
            #player = object.player
            
   if player != null and state == states.chase:
      nav_agent.target_position = player.position
   if alertness == max_alert and state != states.chase:
      set_state(states.chase)
   super(delta)

# ---- #  Physics Process
#func _physics_process(delta: float) -> void:
   #for object in spotted_objects:
      #if object.type == "Player":      # engage the player
         #player = object
         #if threat_detected: nav_agent.target_position = object.position
         #if status != "engaging": status == "engaging"
      #elif object.type == "Guard":
         #if object.state == state.chase: state
         #elif object.status == "engaging":
            #status = "engaging"
            #nav_agent.target_position = object.nav_agent.target_position
         #elif object.status == "dead": status = "alert"
   # ---- # end of for loop # ------------------------------------------------ #
   #if player and spotted_objects.find(player) == -1: player = null
   #super(delta)
