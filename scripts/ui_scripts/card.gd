extends Control
class_name Card

# ---- # nodes
@onready var title := $Outline/MarginContainer/Background/MarginContainer/CardContainer/CardTitle
@onready var image := $Outline/MarginContainer/Background/MarginContainer/CardContainer/CardImage
@onready var description := $Outline/MarginContainer/Background/MarginContainer/CardContainer/CardDescription
@onready var button := $Outline/CardButton

# ---- # variables
var data    # the data that the card holds (Perk or Contract class)

# ---- # Ready
func _ready() -> void:
   title.text = data.name
   #image.texture = data.texture
   description.text = data.description
   Signals.emit_signal("card_created", self)
   add_to_group("Persist")
   
# ---- # Save
func save(array: Array[SavedData]):
   var saved_data = SavedCardData.new()
   saved_data.path = scene_file_path
   saved_data.parent = get_parent().get_path()
   saved_data.data = data
   array.append(saved_data)

# ---- # Before Load Game
func before_load():
   get_parent().remove_child(self)
   queue_free()

# ---- # After Load Game
func after_load(saved_data: SavedData):
   var saved_card = saved_data as SavedCardData
   data = saved_card.data
