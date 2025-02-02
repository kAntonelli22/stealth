extends Control

# ---- # nodes # ---- #
@onready var title := $Background/CardContainer/MarginContainer/TextContainer/CardTitle
@onready var image := $Background/CardContainer/MarginContainer/TextContainer/CardImage
@onready var description := $Background/CardContainer/MarginContainer/TextContainer/CardDescription
@onready var accept := $Background/CardContainer/CardButton

# ---- # variables # ---- #
var type : String
var value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass
