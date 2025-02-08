extends Control

# ---- nodes # ---- #
@onready var resume_button = $Background/MarginContainer/VBoxContainer/Resume
@onready var save_button = $Background/MarginContainer/VBoxContainer/Save
@onready var load_button = $Background/MarginContainer/VBoxContainer/Load
@onready var quit_menu_button = $Background/MarginContainer/VBoxContainer/QuitMenu
@onready var quit_game_button = $Background/MarginContainer/VBoxContainer/QuitGame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Signals.connect("game_saved", enable_load)
   if !SaveManager.save_exists:
      load_button.disabled = true

func enable_load():
   load_button.disabled = false

func _on_resume_pressed() -> void:
   hide()
   get_tree().paused = false

func _on_save_pressed() -> void:
   SaveManager.save_game()

func _on_load_pressed() -> void:
   SaveManager.load_game()

func _on_quit_menu_pressed() -> void:
   get_tree().paused = false
   get_tree().change_scene_to_file("res://scenes/title.tscn")
   hide()

func _on_quit_game_pressed() -> void:
   get_tree().quit()
