extends Resource
class_name SavedGame
#FIXME to string should return a readable timestamp

# ---- # metadata
@export var timestamp: float   # unix timestamp
@export var rounds: int
@export var saved_data: Array[SavedData]

func _to_string() -> String:
   return str(timestamp) + "\nround " + str(rounds)
