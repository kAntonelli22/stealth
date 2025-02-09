extends Camera2D

var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   if player:
      position = player.position

func adjust_camera(new_player : CharacterBody2D, top : int, left : int, bottom : int, right : int):
   player = new_player
   limit_top = top
   limit_left = left
   limit_bottom = bottom
   limit_right = right
