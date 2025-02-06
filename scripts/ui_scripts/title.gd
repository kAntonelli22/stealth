extends Control

# ---- # nodes # ---- #
@onready var continue_button := $Background/MarginContainer/VBoxContainer/Continue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   if Global.save_game_placeholder:
      continue_button.disabled = true
   pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

func _on_continue_pressed():
   print("title: continuing game")
   
func _on_start_game_pressed() -> void:
   get_tree().change_scene_to_packed(Global.card_select)

func _on_settings_pressed() -> void:
   print("title: open settings")

func _on_guide_pressed() -> void:
   print("title: open guide")

func _on_quit_pressed() -> void:
   get_tree().quit()
