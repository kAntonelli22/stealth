extends Control

# ---- # nodes # ---- #
@onready var health_background = $HealthBackground
@onready var pause_menu = $PauseMenu
@onready var saving = $Saving

# ---- # variables # ---- #
var paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Signals.connect("map_changed", connect_signals)

func _input(event: InputEvent) -> void:
   if event.is_action_pressed("pause_menu"): pause_game()

func connect_signals():
   Signals.connect("update_attributes", update_ui)
   Signals.connect("map_changed", enable_health)
   Signals.connect("contract_over", disable_health)

func pause_game():
   pause_menu.show()
   get_tree().paused = true

func update_ui(health : int):
   health_background.update_healthbar(health)

# ---- # enables and disables health bar when out of contract # -------------- #
func enable_health(): health_background.show()
func disable_health(_player_died : bool): health_background.hide()

func _on_pause_button_pressed() -> void:
   pause_menu.show()
   get_tree().paused = true
