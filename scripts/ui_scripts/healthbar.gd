extends ColorRect

# ---- # nodes
@onready var background := $"."
@onready var container := $HealthContainer
@onready var healthbar := $HealthContainer/HealthBar
@onready var text := $HealthContainer/Label

# ---- # export variables
@export var bar_color : Color

# ---- # Ready
func _ready() -> void:
   healthbar.add_theme_color_override("font_color", bar_color)
   text.add_theme_color_override("font_color", bar_color)

# ---- # Update Healthbar
func update_healthbar(health : int):
   healthbar.value = health
   text.text = str(health)
