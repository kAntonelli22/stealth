extends Control

# ---- # nodes # ---- #
@onready var health_background = $HealthBackground
@onready var health_container = $HealthBackground/HealthContainer
@onready var healthbar = $HealthBackground/HealthContainer/HealthBar
@onready var pause_menu = $PauseMenu
@onready var saving = $Saving

# ---- # variables # ---- #
var paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Signals.connect("map_changed", connect_signals)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
   pass

func connect_signals():
   Signals.connect("update_attributes", update_ui)

func update_ui(health : int):
   print("ui: health updated to ", health)
   healthbar.value = health

func _on_pause_button_pressed() -> void:
   pause_menu.show()
   get_tree().paused = true
