extends Control

# ---- # nodes
@onready var continue_button := $Background/MarginContainer/VBoxContainer/Continue

# ---- # Ready
func _ready() -> void:
   if !SaveManager.save_exists:
      continue_button.disabled = true

# ---- # Continue Pressed
func _on_continue_pressed():
   print("title: continuing game")
   SaveManager.load_game()
# ---- # Start Game Pressed
func _on_start_game_pressed() -> void:
   get_tree().change_scene_to_packed(Global.card_select)
# ---- # Settings Pressed
func _on_settings_pressed() -> void:
   print("title: open settings")
# ---- # Guide Pressed
func _on_guide_pressed() -> void:
   print("title: open guide")
# ---- # Quit Pressed
func _on_quit_pressed() -> void:
   get_tree().quit()
