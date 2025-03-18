extends Control

# ---- # nodes
@onready var continue_button := $Background/MarginContainer/VBoxContainer/Continue
@onready var save_slots := $SaveSlots

# ---- # Ready
func _ready() -> void:
   if SaveManager.current_path == "":
      continue_button.disabled = true

# ---- # Continue Pressed
func _on_continue_pressed():
   print("title: continuing game")
   SaveManager.load_game()
# ---- # Start Game Pressed
func _on_new_game_pressed() -> void:
   save_slots.show()
   get_tree().paused = true
# ---- # Settings Pressed
func _on_settings_pressed() -> void:
   print("title: open settings")
# ---- # Guide Pressed
func _on_guide_pressed() -> void:
   print("title: open guide")
# ---- # Quit Pressed
func _on_quit_pressed() -> void:
   get_tree().quit()
