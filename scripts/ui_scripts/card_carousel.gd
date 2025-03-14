extends Control

# ---- # nodes

# ---- # cards
@onready var card_container = $ColorRect/MarginContainer/HBoxContainer
@onready var current_cards = card_container.get_children()

# ---- # Ready
func _ready() -> void:
   for i in range(0, 3):
      if Global.show_perks: instance_card(Perks.perk_deck, "perk")
      else: instance_card(Global.maps, "contract")
      # TODO emit save signal after creating contract cards


# ---- # Process
func _process(_delta: float) -> void:
   pass

# ---- # Card Chosen
# adds a perk to the players stat resource or loads a 
# contract when the player chosen their card
func card_chosen(card: Node):
   if card.card_type == "perk":
      Global.player_stats.add_perk(card.data)
      Global.show_perks = false
      get_tree().change_scene_to_packed(Global.shop)
      #for node in card_container.get_children(): node.queue_free()
      #for i in range(0, 3): instance_card(Global.maps, "contract")
   elif card.card_type == "contract":
      Global.change_map(card.data.value)
      
# ---- # Instance Card
# create a random perk or map card and place it in the container
func instance_card(deck: Dictionary, type: String):
   var picked_card = deck.keys().pick_random()
   var card_data = deck[picked_card]
   if type == "perk": card_data = card_data.new()
   var card = Global.card.instantiate()
   card.card_type = type
   card.data = card_data
   
   card_container.add_child(card)
   card.title.text = card_data.name
   #card.image.texture = card_data.image
   card.description.text = card_data.description
   card.button.pressed.connect(card_chosen.bind(card))
   card.add_to_group("Persist")
