extends Enemy
class_name Target

# ---- # Ready
func _ready() -> void:
   super()
   add_state("flee")
   add_state("escaped")
   call_deferred("set_state", states.idle)

# ---- # State Logic
func _state_logic(delta):
   match(state):
      states.flee:
         if player != null: nav_agent.target_position = get_exit()
      states.escaped:
         return
   super(delta)

# ---- # Get Transition
func _get_transition(_delta):
   match(state):
      states.flee:
         if alertness <= max_alert * .75: return states.idle
   if player != null and state != states.flee and alertness > max_alert *.75: return states.flee
   super(_delta)
   return null
   
# ---- # Get Exit
func get_exit() -> Vector2:
   var current_exit: Node2D = null
   for exit in Global.exits:
      if current_exit == null:
         current_exit = exit
         continue
      if position.distance_to(exit.position) < position.distance_to(current_exit.position):
         current_exit = exit
   if current_exit != null: return current_exit.position
   else: return Vector2(0, 0)

# ---- # Exit
func exit_map():
   print_rich("[color=Darkred]Target has escaped[/color]")
   set_state(states.escaped)
