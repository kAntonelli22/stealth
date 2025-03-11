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
            
   match(state):
      states.hunt:
         pass
      states.chase:
         nav_agent.target_position = player.position
         ai_attack()
         # if weapon.effective_range(player) > 0: nav_agent.target_position = player.position
         # elif weapon.effective_range(player) < 0: backpedal
         # else: hold position
   
   super(delta)

# ---- # Get Transition
func _get_transition(_delta):
   match(state):
      states.idle:
         if alertness >= max_alert * .75: 
            #vision_cone.angle_deg += 30  # vision cone doesnt update until reloaded
            return states.hunt
      states.patrol:
         if alertness >= max_alert * .75: 
            #vision_cone.angle_deg += 30
            return states.hunt
      states.hunt:
         if player != null: return states.chase
         # if detection shadow is within vision cone: return states.idle
         if alertness <= max_alert * .75: 
            #vision_cone.angle_deg -= 30
            return states.idle
      states.chase:
         if player == null: return states.hunt
   return super(_delta)
