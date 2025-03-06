extends StateMachine
class_name Enemy

# ---- # nodes
@onready var sprite := $Sprite
@onready var vision_cone := $VisionCone
@onready var collider := $Collider
@onready var detection_shadow := $DetectionShadow
@onready var detection_bar := $DetectionBar
@onready var nav_agent := $NavigationAgent2D
@onready var weapon_slot := $Weapon
var weapon: Node2D
var player: CharacterBody2D


# ---- # sight variables
var spotted_objects: Array = []     # holds all objects the enemy currently sees
var alertness: int = 0
var max_alert: int = 100

# ---- # enemy stats
var health: int = 100      # 0 - 100
var speed: float = 200.0
var rotate_speed: float = 2.0

# ---- # path variables
var path_route: Array[Vector2]
var path_route_x: Array
var path_route_y: Array
var current_point: int = 0

# ---- # Ready
func _ready() -> void:
   position = next_route_position()
   add_state("idle")
   add_state("patrol")

# ---- # Process
func _process(_delta: float) -> void:
   #if alertness > 25 and detection_bar.value <= 25: vision_cone.angle_deg += vision_cone.angle_deg + 30
   #elif alertness <= 25 and detection_bar.value > 25: vision_cone.angle_deg -= vision_cone.angle_deg - 30
   detection_bar.value = alertness
   
   if health <= 0:
      print_rich("[color=Orangered]enemy[/color]: enemy ", self.name, " has died")
      vision_cone.visible = false
      detection_bar.visible = false
      process_mode = PROCESS_MODE_DISABLED      # pause node on death

# ---- # State Logic
# contains the logic for state actions and transitions
func _state_logic(delta):
   if player:
      if spotted_objects.find(player) == -1: player = null
      else: alertness += 1
   else: alertness -= 1
   alertness = clamp(alertness, 0, max_alert)
   
   #var player
   for object in spotted_objects:
      if object is Player: player = object
      elif object is Enemy:
         if object.player != null:
            player = object.player
   
   if state == states.idle and path_route.size() > 0 and position.distance_to(path_route[current_point]) > 15:
      set_state(states.patrol)
   
   if state != states.idle:
      var next_position = nav_agent.get_next_path_position()
      var angle_to := position.angle_to_point(next_position)
      var relative_angle = fmod(angle_to - rotation + PI, PI * 2) - PI
      var angle = abs(rad_to_deg(relative_angle))
      move(next_position, angle, angle_to, delta)

# ---- # Get Transition
# contains the logic for transitioning between states
#func _get_transition(_delta):
   #match(state):
      #states.idle:
         #if path_route.size() > 0: return states.patrol
      #states.patrol: pass
   #return null

# ---- # Move
func move(next_position, angle, angle_to, delta):
   var next_velocity = position.direction_to(next_position) * speed
   var next_rotation = rotate_toward(rotation, angle_to, delta * rotate_speed)
   
   if !nav_agent.is_navigation_finished():
      if angle <= 15:
         rotation = next_rotation
         velocity = next_velocity
      else:
         rotation = next_rotation
         velocity = Vector2.ZERO
   elif path_route.size() > 0:
      nav_agent.target_position = next_route_position()
   move_and_slide()

func _on_vision_cone_entered(body: Node2D) -> void:
   if body != self: spotted_objects.append(body)

func _on_vision_cone_exited(body: Node2D) -> void:
   if body != self: spotted_objects.remove_at(spotted_objects.find(body))

# ---- # Next Route Position
# returns the next route index and sets the index to the next one
func next_route_position() -> Vector2:
   var index = current_point
   if current_point < path_route.size() - 1: current_point += 1
   else: current_point = 0
   return path_route[index]

# ---- # Hit
func hit(holder : CharacterBody2D, _p_weapon : Node2D, damage : int):
   if health <= 0: return
   if spotted_objects.find(holder) and alertness <= (.25 * max_alert): # and weapon.type == "stealth":
      print_rich("[color=Orangered]enemy[/color]: hit by stealth takedown")
      health = 0
   else:
      health -= damage
      print_rich("[color=Orangered]enemy[/color]: health reduced to ", health)
      alertness = 100
      # change state to deal with the attack
      # move towards the direction of the attack

# ---- # AI Attack
func ai_attack():
   if player and weapon and weapon.can_hit(player):
      if weapon.cooldown <= weapon.recharge: weapon.attack(self)

# ---- # Save 
func save() -> Dictionary:
   path_route_x = []
   path_route_y = []
   for point in path_route:
         path_route_x.append(point.x)
         path_route_y.append(point.y)
   var save_dict = {
      "type": "node",
      "filename": get_scene_file_path(),
      "parent": get_parent().get_path(),
      "position_x": position.x,
      "position_y": position.y,
      "rotation": rotation,
      "health": health,
      "speed": speed,
      "rotate_speed": rotate_speed,
      "nav_agent.target_position.x": nav_agent.target_position.x,
      "nav_agent.target_position.y": nav_agent.target_position.y,
      "path_route_x": path_route_x,
      "path_route_y": path_route_y,
      "spotted_objects": spotted_objects,
      "alertness": alertness,
      "weapon": weapon.save(),
   }
   return save_dict

# ---- # Custom Load
# called by SaveManager
# stitches path_route json arrays back together
func custom_load():
   for i in range(0, path_route_x.size()):
      path_route.append(Vector2(path_route_x[i], path_route_y[i]))
