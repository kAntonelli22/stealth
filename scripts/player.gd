extends CharacterBody2D

# ---- # physics variables # ---- #
const SPEED = 300.0

# ---- # logic variables # ---- #
var type : String = "Player"

# ---- # player stats # ---- #
var health : int = 100     # 0 - 100

# ---- # nodes  # ---- #
@onready var weapon : Node2D = $Melee

func _physics_process(delta: float) -> void:
   # ---- # get mouse position and direction the player is moving # ---------- #
   var mouse_position : Vector2 = get_global_mouse_position()
   var direction : Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
   
   if direction.x: velocity.x = direction.x * SPEED
   else: velocity.x = move_toward(velocity.x, 0, SPEED)
   if direction.y: velocity.y = direction.y * SPEED
   else: velocity.y = move_toward(velocity.y, 0, SPEED)
   
   look_at(mouse_position)
   rotation += deg_to_rad(90)
   move_and_slide()

func _input(event: InputEvent) -> void:
   # handle attack event
   if event.is_action_pressed("attack"):
      print("player: attacking")
      weapon.attack()
   if event.is_action_pressed("dash"):
      print("player: dashing")
