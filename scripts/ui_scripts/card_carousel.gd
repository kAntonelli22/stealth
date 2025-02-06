extends Control

# ---- # nodes # ---- #

# ---- # cards # ---- #
@onready var card_container = $ColorRect/MarginContainer/HBoxContainer
@onready var current_cards = card_container.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass # Replace with function body.
   for i in range(0, 3):
      if Global.show_perks: instance_card(Perks.perk_deck, "perk")
      else: instance_card(Global.maps, "contract")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
   pass

# ---- # card chosen function called when the player choses their card # ----- #
func card_chosen(card: Node):
   if card.type == "perk":
      Global.player_stats.add_perk(card.data)
      Global.show_perks = false
      get_tree().change_scene_to_packed(Global.card_select)
   elif card.type == "contract":
      Global.change_map(card.data.value)
      
# ---- # instance a random card from the provided deck # --------------------- #
func instance_card(deck: Dictionary, type: String):
   var picked_card = deck.keys().pick_random()
   var card_data = deck[picked_card]
   if type == "perk": card_data = card_data.new("Speed Perk", "increases the players speed", "Boost")
   var card = Global.card.instantiate()
   card.type = type
   card.data = card_data
   
   card_container.add_child(card)
   card.title.text = card_data.name
   #card.image.texture = card_data.image
   card.description.text = card_data.description
   card.accept.pressed.connect(card_chosen.bind(card))
