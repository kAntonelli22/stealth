extends Control

# ---- nodes
@onready var resume_button = $Background/MarginContainer/VBoxContainer/Resume
@onready var save_button = $Background/MarginContainer/VBoxContainer/Save
@onready var load_button = $Background/MarginContainer/VBoxContainer/Load
@onready var quit_menu_button = $Background/MarginContainer/VBoxContainer/QuitMenu
@onready var quit_game_button = $Background/MarginContainer/VBoxContainer/QuitGame

# ---- # Ready
func _ready() -> void:
   Signals.connect("game_saved", enable_load)
   if SaveManager.current_path == "":
      load_button.disabled = true

# ---- # Enable Load
func enable_load(): load_button.disabled = false
# ---- # Unpause Game
func unpause_game():
   hide()
   get_tree().paused = false

# ---- # Resume Pressed
func _on_resume_pressed() -> void: unpause_game()
# ---- # Save Pressed
func _on_save_pressed() -> void:
   SaveManager.save_game()
# ---- # Load Pressed
func _on_load_pressed() -> void:
   unpause_game()
   SaveManager.load_game()
# ---- # Quit To Menu Pressed
func _on_quit_menu_pressed() -> void:
   unpause_game()
   get_tree().change_scene_to_file("res://scenes/ui_scenes/title.tscn")
# ---- # Quit Game Pressed
func _on_quit_game_pressed() -> void:
   get_tree().quit()
