extends Enemy
class_name Guard

# ---- # Ready
func _ready() -> void:
   super()
   add_state("hunt")
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
   if alertness <= max_alert * .75 and state == states.chase:
      set_state(states.idle)
   super(delta)
