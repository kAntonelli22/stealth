extends CharacterBody2D
class_name Enemy

# ---- # nodes # ---- #
@onready var sprite := $Sprite
@onready var vision_cone := $VisionCone
@onready var collider := $Collider
@onready var detection_shadow := $DetectionShadow
@onready var detection_bar := $DetectionBar
@onready var nav_agent := $NavigationAgent2D
var weapon: Node2D
var player: CharacterBody2D

# ---- # logic variables # ---- #
var type: String = "Guard"
var status: String = "normal"       # normal | alert | engaging | dead
var alert: bool = false

# ---- # sight variables # ---- #
var spotted_objects: Array = []     # holds all objects the guard currently sees
var detection: int = 0              # 0 - 100
var threat_detected: bool = false

# ---- # guard stats # ---- #
var health: int = 100      # 0 - 100
var speed: float = 200.0
var rotate_speed: float = 2.0

# ---- # path variables # ---- #
var path_route : Array[Vector2]
var current_point : int = 0

func _ready() -> void:
   position = path_route[current_point]
   if current_point < path_route.size() - 1: current_point += 1

func _process(_delta: float) -> void:
   detection_bar.value = detection
   if health <= 0:
      print("enemy: enemy ", self.name, " has died")
      status = "dead"
      vision_cone.visible = false
      detection_bar.visible = false
      process_mode = PROCESS_MODE_DISABLED      # pause node on death

func _physics_process(delta: float) -> void:
   
   var next_position = nav_agent.get_next_path_position()
   var angle_to := position.angle_to_point(next_position)
   var relative_angle = fmod(angle_to - rotation + PI, PI * 2) - PI
   var angle = abs(rad_to_deg(relative_angle))
   
   if player:
      if player and detection < 100: detection += 1
      if detection == 100:
         threat_detected = true
         ai_attack()
   
   # if ai is navigating and the angle to target is less than 90
   if !nav_agent.is_navigation_finished() and angle <= 15:
      rotation = rotate_toward(rotation, angle_to, delta * rotate_speed)
      velocity = global_position.direction_to(next_position) * speed
   elif !nav_agent.is_navigation_finished():
      rotation = rotate_toward(rotation, angle_to, delta * rotate_speed)
      velocity = Vector2.ZERO
   elif nav_agent.is_navigation_finished() and path_route.size() > 0:
      nav_agent.target_position = path_route[current_point]
      if current_point < path_route.size() - 1: current_point += 1
      else: current_point = 0
   move_and_slide()

func _on_vision_cone_entered(body: Node2D) -> void:
   if body != self: spotted_objects.append(body)

func _on_vision_cone_exited(body: Node2D) -> void:
   if body != self: spotted_objects.remove_at(spotted_objects.find(body))

# ---- # called by weapons on objects they have hit # ------------------------ #
func hit(holder : CharacterBody2D, _p_weapon : Node2D, damage : int):
   if status == "dead": return
   if spotted_objects.find(holder) and status != "engaging": # and weapon.type == "stealth":
      print("enemy: hit by stealth takedown")
      health = 0
   else:
      health -= damage
      print("health: ", health)
      detection = 100

func ai_attack():
   if player and weapon and weapon.can_hit(player):
      if weapon.cooldown <= weapon.recharge: weapon.attack(self)

# ---- # called by global save function when the player is present in the scene
func save() -> Dictionary:
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
      "status": status,
      "spotted_objects": spotted_objects,
      "detection": detection,
      "threat_detected": threat_detected,
      "weapon": weapon.save(),
   }
   return save_dict
