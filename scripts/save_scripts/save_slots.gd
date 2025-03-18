extends ColorRect
# HACK saveslots should not use hardcoded save strings

# ---- # Nodes
@onready var slot1 := $Control/Background/MarginContainer/VBoxContainer/HBoxContainer/Slot1
@onready var slot2 := $Control/Background/MarginContainer/VBoxContainer/HBoxContainer/Slot2
@onready var slot3 := $Control/Background/MarginContainer/VBoxContainer/HBoxContainer/Slot3

func _ready() -> void:
   if SaveManager.slot1 != null: slot1.text = SaveManager.slot1._to_string()
   if SaveManager.slot2 != null: SaveManager.slot2._to_string()
   if SaveManager.slot3 != null: SaveManager.slot3._to_string()
   

func _on_slot_1_pressed() -> void:
   get_tree().paused = false
   SaveManager.current_path = "user://savegame1.tres"
   Global.change_scene(Global.card_select)

func _on_slot_2_pressed() -> void:
   get_tree().paused = false
   SaveManager.current_path = "user://savegame2.tres"
   Global.change_scene(Global.card_select)

func _on_slot_3_pressed() -> void:
   get_tree().paused = false
   SaveManager.current_path = "user://savegame3.tres"
   Global.change_scene(Global.card_select)
