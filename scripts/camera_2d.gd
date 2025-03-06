extends Camera2D

var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Signals.connect("map_loaded", update_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
   if player != null: position = player.position

# ---- # Adjust Camera
# called when map is loaded to limit camera to map and bind it to player
func adjust_camera(new_player: CharacterBody2D, top: int, left: int, bottom: int, right: int):
   player = new_player
   limit_top = top
   limit_left = left
   limit_bottom = bottom
   limit_right = right

# ---- # Update Player
# activated when SaveManager loads a map and ensures 
# it is following the right player
func update_player(_map, new_player: CharacterBody2D):
   player = new_player
