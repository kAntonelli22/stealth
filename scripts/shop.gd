extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

# TODO offer items to be purchased
# TODO show money player has

func _on_contract_button_pressed() -> void:
   Global.show_perks = false;
   get_tree().change_scene_to_packed(Global.card_select)
