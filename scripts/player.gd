extends StateMachine
class_name Player

# ---- # logic variables
var type : String = "Player"
var dashing : bool = false

# ---- # player stats
@export var stats : Resource
@onready var health : int = stats.health
@onready var health_regen : int = stats.health_regen
@onready var speed : float = stats.speed
@onready var stamina : float = stats.stamina
@onready var stamina_regen : float = stats.stamina_regen
@onready var dash_speed : float = stats.dash_speed
@onready var dash_cost : int = stats.dash_cost
# ---- # player perks
@onready var active_perks = stats.perks

# ---- # nodes
@onready var sprite : Node2D = $Sprite
@onready var collider : Node2D = $Collider
@onready var dash_timer : Timer = $DashTimer
@onready var weapon_slot := $Weapon
@onready var weapon : Node2D = $Weapon/Fists

# ---- # Ready
func _ready() -> void:
   # add states
   #add_state("Idle")
   #add_state("Move")
   #add_state("Attack")
   #add_state("Dash")
   #call_deferred(set_state("Idle"))
   
   add_to_group("Persist")
   print_rich("[color=Royalblue]Current Player Perks[/color]: ", active_perks)
   for perk in active_perks:
      perk.apply_perk(self)

# ---- # Process
func _process(_delta: float) -> void:
   sprite.rotation = -rotation

# ---- # Physics Process
func _physics_process(delta: float) -> void:
   if health <= 0: Signals.emit_signal("contract_over", true)
   # get mouse position and direction the player is moving
   var mouse_position : Vector2 = get_global_mouse_position()
   var direction : Vector2 = get_direction()
   move(direction, speed)
   if !dash_timer.is_stopped() and stamina >= dash_cost: move(direction, dash_speed)
   if stamina < 100: stamina += delta * stamina_regen    # regenerate stamina every physics frame
   
   look_at(mouse_position)
   move_and_slide()

# ---- # Input
func _input(event: InputEvent) -> void:
   # handle attack event
   if event.is_action_pressed("attack") and weapon.cooldown <= weapon.recharge: weapon.attack(self)
   if event.is_action_pressed("dash") and stamina >= dash_cost:
      stamina -= dash_cost
      dash_timer.start()

# ---- # State Logic
#func _state_logic(delta):
   #if state == "Idle":
      #velocity.x = move_toward(velocity.x, 0, speed)
      #velocity.y = move_toward(velocity.y, 0, speed)
   #elif state == states.move:
      #var direction : Vector2 = get_direction()
      #velocity.x = direction.x * speed
      #velocity.y = direction.y * speed
   #elif state == "Attack":
      #pass
   #elif state == states.dash:
      #var direction : Vector2 = get_direction()
      #velocity.x = direction.x * dash_speed
      #velocity.y = direction.y * dash_speed

# ---- # Get Direction
func get_direction() -> Vector2:
   return Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
   
# ---- # Move
func move(direction, move_speed):
   if direction.x: velocity.x = direction.x * move_speed
   else: velocity.x = move_toward(velocity.x, 0, move_speed)
   if direction.y: velocity.y = direction.y * move_speed
   else: velocity.y = move_toward(velocity.y, 0, move_speed)
   
# ---- # Hit
func hit(holder : CharacterBody2D, _holder_weapon : Node2D, damage : int):
   print_rich("[color=Royalblue]Player[/color]: hit by [color=Darkred]", holder, "[/color] for [color=Darkred]", damage, "[/color]")
   health -= damage
   Signals.emit_signal("update_attributes", health)

# ---- # Exit
func exit_map():
   print_rich("[color=Royalblue]Player[/color]: exiting map")
   Signals.emit_signal("contract_over", false)

# ---- # Save
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
      "dash_speed": dash_speed,
      "dash_cost": dash_cost,
      "weapon": weapon.save(),
      "active_perks": perk_dict,
   }
   return save_dict
