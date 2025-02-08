extends CharacterBody2D
class_name Enemy

# ---- # nodes # ---- #
@onready var sprite := $Sprite
@onready var vision_cone := $VisionCone
@onready var collider := $Collider
@onready var detection_shadow := $DetectionShadow
@onready var detection_bar := $DetectionBar
var weapon

# ---- # physics variables # ---- #
var speed : float = 200.0
var rotate_speed : float = 2.0
var move_target : Vector2 = Vector2(-1, -1)

# ---- # logic variables # ---- #
var type : String = "Guard"
var status : String = "normal"      # normal | alert | engaging | dead
var alert : bool = false

# ---- # sight variables # ---- #
var spotted_objects : Array = []    # holds all objects the guard currently sees
var detection : int = 0             # 0 - 100
var threat_detected : bool = false

# ---- # guard stats # ---- #
var health : int = 100     # 0 - 100

func _process(_delta: float) -> void:
   detection_bar.value = detection
   if health <= 0:
      print("enemy: enemy ", self.name, " has died")
      status = "dead"
      vision_cone.visible = false
      detection_bar.visible = false
      process_mode = PROCESS_MODE_DISABLED      # pause node on death

func _physics_process(delta: float) -> void:
   if move_target != position and move_target != Vector2(-1, -1):
      position = position.move_toward(move_target, delta * speed)
      var angle_to := position.angle_to_point(move_target) + deg_to_rad(90)
      rotation = lerp_angle(rotation, angle_to, delta * rotate_speed)
   if move_target == position:
      pass
      # return to last patrol point 
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

func ai_attack(player: CharacterBody2D):
   if player and weapon and weapon.can_hit(player):
      if weapon.cooldown <= weapon.recharge: weapon.attack()

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
      "move_target_x": move_target.x,
      "move_target_y": move_target.y,
      "status": status,
      "spotted_objects": spotted_objects,
      "detection": detection,
      "threat_detected": threat_detected,
      "weapon": weapon.save(),
   }
   return save_dict
