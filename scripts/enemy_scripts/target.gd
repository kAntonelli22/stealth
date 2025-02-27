extends Enemy
class_name Target

# ---- # Ready
func _ready() -> void:
   super()
   add_state("run")
   call_deferred("set_state", states.idle)

# ---- # State Logic
func _state_logic(delta):
   #for object in spotted_objects:
      #if object is Player: player = object
      #elif object is Guard:
         #if object.state == state.chase:
            #set_state("chase")
            #player = object.player
            
   if player != null and state == states.run:
      #nav_agent.target_position = player.position
      nav_agent.target_position = get_exit() # get nearest exit and run to it. this is bad
   if alertness == max_alert and state != states.run:
      set_state(states.run)
   super(delta)

# ---- # Get Exit
func get_exit() -> Vector2:
   var current_exit: Node2D
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
   print("target: exiting scene")
