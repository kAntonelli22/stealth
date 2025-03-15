extends ColorRect

# TODO get save slot info from SaveManager on scene load

func _ready() -> void:
   pass
   

func _on_slot_1_pressed() -> void:
   get_tree().paused = false
   get_tree().change_scene_to_packed(Global.card_select)

func _on_slot_2_pressed() -> void:
   get_tree().paused = false
   get_tree().change_scene_to_packed(Global.card_select)

func _on_slot_3_pressed() -> void:
   get_tree().paused = false
   get_tree().change_scene_to_packed(Global.card_select)
