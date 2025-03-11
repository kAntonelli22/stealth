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
func adjust_camera(new_player: CharacterBody2D, background: Polygon2D):
   player = new_player
   var points: PackedVector2Array = background.polygon
   var min_x = points[0].x
   var max_x = points[0].x
   var min_y = points[0].y
   var max_y = points[0].y
   
   for point in points:
      min_x = min(min_x, point.x)
      max_x = max(max_x, point.x)
      min_y = min(min_y, point.y)
      max_y = max(max_y, point.y)
   
   limit_top = min_y
   limit_left = min_x - 256   # size of ui
   limit_bottom = max_y
   limit_right = max_x

# ---- # Update Player
# activated when SaveManager loads a map and ensures 
# it is following the right player
func update_player(_map, new_player: CharacterBody2D):
   player = new_player
