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

func _on_contract_button_pressed() -> void:
   Global.show_perks = false;
   Global.change_scene(Global.card_select)
