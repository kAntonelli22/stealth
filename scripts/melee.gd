extends Node2D

@onready var holder : Node2D = get_parent()
var hurtbox_objects : Array = []
var directionbox_objects : Array = []

# ---- # weapon stats # ---- #
var damage : int = 10
var attack_speed : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   pass # Replace with function body.

func attack():
   for object in hurtbox_objects:
      if object != holder and directionbox_objects.has(object):
         object.health -= damage    # replace with object hit signal
         print("melee: ", object.type, " hit for ", damage, " damage")


func _on_hurtbox_entered(body: Node2D) -> void:
   print("melee: hurtbox entered by: ", body.type)
   hurtbox_objects.append(body)

func _on_hurtbox_exited(body: Node2D) -> void:
   print("melee: hurtbox exited by: ", body.type)
   hurtbox_objects.remove_at(hurtbox_objects.find(body))

func _on_direction_box_entered(body: Node2D) -> void:
   print("melee: directionbox entered by: ", body.type)
   directionbox_objects.append(body)

func _on_direction_box_exited(body: Node2D) -> void:
   print("melee: directionbox exited by: ", body.type)
   directionbox_objects.remove_at(directionbox_objects.find(body))
   
