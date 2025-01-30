extends CharacterBody2D

# ---- # physics variables # ---- #
const SPEED = 300.0

# ---- # logic variables # ---- #
var type : String = "Player"
var dashing : bool = false

# ---- # player stats # ---- #
var health : int = 100        # 0 - 100
var stamina : int = 100       # 0 - 100
var dash_distance : int = 75  # distance that is added to velocity when dashing
var dash_cost : int = 10      # amount subtracted from stamina when dashing

# ---- # nodes  # ---- #
@onready var sprite : Node2D = $Sprite
@onready var collider : Node2D = $Collider
@onready var weapon : Node2D = $Melee

func _physics_process(delta: float) -> void:
   # ---- # get mouse position and direction the player is moving # ---------- #
   var mouse_position : Vector2 = get_global_mouse_position()
   var direction : Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
   
   if direction.x: velocity.x = direction.x * SPEED
   else: velocity.x = move_toward(velocity.x, 0, SPEED)
   if direction.y: velocity.y = direction.y * SPEED
   else: velocity.y = move_toward(velocity.y, 0, SPEED)
   
   if dashing and stamina >= dash_cost:
      position = position.move_toward(mouse_position, dash_distance)
      stamina -= dash_cost
      dashing = false
      print("player: dashed, stamina at ", stamina)
   
   look_at(mouse_position)
   rotation += deg_to_rad(90)
   if stamina < 100: stamina += 1 * delta    # regenerate stamina every physics frame
   move_and_slide()

func _input(event: InputEvent) -> void:
   # handle attack event
   if event.is_action_pressed("attack"):
      print("player: attacking")
      weapon.attack()
   if event.is_action_pressed("dash"):
      print("player: dashing")
      dashing = true
