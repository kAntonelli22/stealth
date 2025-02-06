extends Control
class_name Card

# ---- # nodes # ---- #
@onready var title := $Background/CardContainer/MarginContainer/TextContainer/CardTitle
@onready var image := $Background/CardContainer/MarginContainer/TextContainer/CardImage
@onready var description := $Background/CardContainer/MarginContainer/TextContainer/CardDescription
@onready var accept := $Background/CardContainer/CardButton

# ---- # variables # ---- #
var type : String       # the type of card (perk or map)
var data                # the data that the card holds (effects, bonuses, map configs)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass # Replace with function body.
