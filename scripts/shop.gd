extends Control

# TODO offer items to be purchased

# ---- # Nodes
@onready var money := $ColorRect/MarginContainer/Money


func change_money(change: int):
   Global.player_stats.money -= change
   update_money()

func update_money():
   money.text = "money: " + str(Global.player_stats.money)
   

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   update_money()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

func _on_contract_button_pressed() -> void:
   Global.show_perks = false;
   get_tree().change_scene_to_packed(Global.card_select)
