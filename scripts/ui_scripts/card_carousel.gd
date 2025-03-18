extends Control

# FIXME when save games are loaded the cards are not created through card factory
# this causes their pressed signals to not e received
# ---- # nodes

# ---- # cards
@onready var card_container = $ColorRect/MarginContainer/HBoxContainer
@onready var current_cards = card_container.get_children()

# ---- # Ready
func _ready() -> void:
   if card_container.get_child_count(false) == 0:
      if Global.show_perks:
         for i in range(0, 3): 
            var perk_card = Perks.perk_deck[Perks.perk_deck.keys().pick_random()].new()
            card_factory(perk_card)
      else:
         for i in range(0, 3):
            var contract = Global.contracts[Global.contracts.keys().pick_random()].new()
            card_factory(contract)
         Signals.emit_signal("save_game")


# ---- # Process
func _process(_delta: float) -> void:
   pass

# ---- # Card Chosen
# adds a perk to the players stat resource or loads a 
# contract when the player chosen their card
func card_chosen(data):
   if data is Perk:
      Global.player_stats.add_perk(data)
      Global.show_perks = false
      Global.change_scene(Global.shop)
   elif data is Contract:
      Global.start_contract(data)

# ---- # Card Factory
func card_factory(data):
   var card = Global.card.instantiate()
   card.data = data
   card_container.add_child(card)
   card.button.pressed.connect(card_chosen.bind(card.data))
   if data is Contract:
      card.add_to_group("Persist")
