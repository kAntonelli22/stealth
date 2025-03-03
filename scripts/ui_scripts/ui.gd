extends CanvasLayer

# ---- # nodes
@onready var health_background = $LeftPanel/LeftContainer/HealthBackground
@onready var pause_menu = $PauseMenu
@onready var saving = $LeftPanel/Saving
@onready var carrot = $LeftPanel/Carrot
@onready var entrance_container = $LeftPanel/LeftContainer/EntranceContainer

# ---- # variables
var paused : bool = false

# ---- # Ready
func _ready() -> void:
   Signals.connect("map_changed", connect_signals)

# ---- # Input
func _input(event: InputEvent) -> void:
   if event.is_action_pressed("pause_menu"): pause_game()

# ---- # Connect Signals
func connect_signals():
   Signals.connect("update_attributes", update_ui)
   Signals.connect("map_changed", enable_health)
   Signals.connect("contract_over", disable_health)
   Signals.connect("new_entrance", new_entrance)

# ---- # Pause Game
func pause_game():
   pause_menu.show()
   get_tree().paused = true

# ---- # Update UI
func update_ui(health : int):
   health_background.update_healthbar(health)

func new_entrance(entrance: Node2D):
   print_rich("[color=AquaMarine]UI[/color]: entrance signal received")
   var entrance_ui = Global.entrance_ui.instantiate()
   entrance_container.add_child(entrance_ui)

# ---- # Enable and Disable Health
func enable_health(): health_background.show()
func disable_health(_player_died : bool): health_background.hide()

# ---- # Pause Button Pressed
func _on_pause_button_pressed() -> void:
   pause_menu.show()
   get_tree().paused = true
