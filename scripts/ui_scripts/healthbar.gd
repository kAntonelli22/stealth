extends HBoxContainer

# ---- # nodes
@onready var healthbar := $HealthBar
@onready var text := $Label

# ---- # export variables
#@export var bar_color : Color

# ---- # Ready
func _ready() -> void:
   pass
   #healthbar.add_theme_color_override("font_color", bar_color)
   #text.add_theme_color_override("font_color", bar_color)

# ---- # Update Healthbar
func update_healthbar(health : int):
   healthbar.value = health
   text.text = str(health)
