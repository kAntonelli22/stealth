extends Resource
class_name SavedGame

# ---- # metadata
@export var timestamp: float   # unix timestamp
@export var rounds: int
@export var saved_data: Array[SavedData]
@export var player_stats := ResourceSaver.save(Global.player_stats)

func _to_string() -> String:
   return Time.get_datetime_string_from_unix_time(timestamp, true) + "\nround " + str(rounds)
