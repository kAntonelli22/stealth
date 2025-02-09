extends CharacterBody2D
class_name Player

# ---- # logic variables # ---- #
var type : String = "Player"
var dashing : bool = false

# ---- # player stats # ---- #
@export var stats : Resource
@onready var health : int = stats.health
@onready var health_regen : int = stats.health_regen
@onready var speed : float = stats.speed
@onready var stamina : float = stats.stamina
@onready var stamina_regen : float = stats.stamina_regen
@onready var dash_distance : int = stats.dash_distance
@onready var dash_cost : int = stats.dash_cost

# ---- # player perks # ---- #
@onready var active_perks = stats.perks

# ---- # nodes  # ---- #
@onready var sprite : Node2D = $Sprite
@onready var collider : Node2D = $Collider
@onready var weapon : Node2D = $Weapon

func _ready() -> void:
   add_to_group("Persist")
   print(active_perks)
   for perk in active_perks:
      perk.apply_perk(self)

func _physics_process(delta: float) -> void:
   if health <= 0: Signals.emit_signal("contract_over", true)
   # ---- # get mouse position and direction the player is moving # ---------- #
   var mouse_position : Vector2 = get_global_mouse_position()
   var direction : Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
   
   if direction.x: velocity.x = direction.x * speed
   else: velocity.x = move_toward(velocity.x, 0, speed)
   if direction.y: velocity.y = direction.y * speed
   else: velocity.y = move_toward(velocity.y, 0, speed)
   
   if dashing and stamina >= dash_cost:
      position = position.move_toward(mouse_position, dash_distance)
      stamina -= dash_cost
      dashing = false
   if stamina < 100: stamina += delta * stamina_regen    # regenerate stamina every physics frame
   
   look_at(mouse_position)
   rotation += deg_to_rad(90)
   move_and_slide()

func _input(event: InputEvent) -> void:
   # handle attack event
   if event.is_action_pressed("attack") and weapon.cooldown <= weapon.recharge: weapon.attack(self)
   if event.is_action_pressed("dash"): dashing = true

# ---- # called by weapons on objects they have hit # ------------------------ #
func hit(_holder : CharacterBody2D, _holder_weapon : Node2D, damage : int):
   health -= damage
   print("player: took ", damage, " damage")
   Signals.emit_signal("update_attributes", health)

func exit():
   Signals.emit_signal("contract_over", false)

# ---- # called by global save function when the player is present in the scene
func save() -> Dictionary:
   var perk_dict : Dictionary
   for perk in active_perks:
      perk_dict.get_or_add(perk, perk.save())
   var save_dict = {
      "type": "node",
      "filename": get_scene_file_path(),
      "parent": get_parent().get_path(),
      "position_x": position.x,
      "position_y": position.y,
      "rotation": rotation,
      "health": health,
      "health_regen": health_regen,
      "speed": speed,
      "stamina": stamina,
      "stamina_regen": stamina_regen,
      "dash_distance": dash_distance,
      "dash_cost": dash_cost,
      "weapon": weapon.save(),
      "active_perks": perk_dict,
   }
   return save_dict
