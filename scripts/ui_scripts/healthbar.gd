extends ColorRect

# ---- # nodes # ---- #
@onready var background := $"."
@onready var container := $HealthContainer
@onready var healthbar := $HealthContainer/HealthBar
@onready var text := $HealthContainer/Label

# ---- # export variables # ---- #
@export var bar_color : Color

func _ready() -> void:
   healthbar.add_theme_color_override("font_color", bar_color)
   text.add_theme_color_override("font_color", bar_color)

func update_healthbar(health : int):
   healthbar.value = health
   text.text = str(health)
