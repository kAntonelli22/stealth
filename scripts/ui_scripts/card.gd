extends Control
class_name Card

# FIXME card does not load data after loading save

# ---- # nodes
@onready var title := $Outline/MarginContainer/Background/MarginContainer/CardContainer/CardTitle
@onready var image := $Outline/MarginContainer/Background/MarginContainer/CardContainer/CardImage
@onready var description := $Outline/MarginContainer/Background/MarginContainer/CardContainer/CardDescription
@onready var button := $Outline/CardButton

# ---- # variables
var card_type : String       # the type of card (perk or map)
var data                # the data that the card holds (effects, bonuses, map configs)

# ---- # Ready
func _ready() -> void:
   pass

# ---- # Save 
func save() -> Dictionary:
   var save_dict = {
      "type": "node",
      "filename": get_scene_file_path(),
      "parent": get_parent().get_path(),
      "card_type": card_type,
      "data": data,
      "title_text": title.text,
      "image_texture": image.texture,
      "description_text": description.text,
   }
   return save_dict
