extends Node
# ---- # SaveManager
# TODO finish resource SaveManager implementation
# TODO create SavedData class
# FIXME save slots 2 and 3 do not work?
# FIXME saves dont work until the game is restarted

# ---- # variables
var current_path: String
var current_save: SavedGame
var slot1: SavedGame
var slot2: SavedGame
var slot3: SavedGame
var slots: Array = [slot1, slot2, slot3]

# ---- # Ready
func _ready():
   Signals.connect("save_game", save_game)
   Signals.connect("load_game", load_game)
   if FileAccess.file_exists("user://savegame1.tres"): slot1 = load("user://savegame1.tres") as SavedGame
   if FileAccess.file_exists("user://savegame2.tres"): slot2 = load("user://savegame2.tres") as SavedGame
   if FileAccess.file_exists("user://savegame3.tres"): slot3 = load("user://savegame3.tres") as SavedGame
   
   print_rich("[color=#64649E]SaveManager[/color]: determining most recent save")
   var temp_slot = slot1
   for slot in slots:
      if slot != null:
         if temp_slot == null: temp_slot = slot
         elif slot.timestamp > temp_slot.timestamp: temp_slot = slot
   if temp_slot != null: 
      current_path = temp_slot.resource_path
      current_save = temp_slot
         

func save_game():
   print_rich("[color=#64649E]SaveManager[/color]: saving game")
   var saved_game: SavedGame = SavedGame.new()
   saved_game.timestamp = Time.get_unix_time_from_system()
   saved_game.rounds = Global.rounds
   
   var saved_data: Array[SavedData] = []
   get_tree().call_group("Persist", "save", saved_data)
   saved_game.saved_data = saved_data
   
   ResourceSaver.save(saved_game, current_path)
   print_rich("[color=#64649E]SaveManager[/color]: game saved")

func load_game():
   print_rich("[color=#64649E]SaveManager[/color]: loading game")
   if current_path == null or current_save == null:
      print_rich("[color=#64649E]SaveManager[/color]: [color=Crimson]no file to load[/color]")
      return
   Global.change_scene(Global.card_select)
   await get_tree().process_frame
   await get_tree().process_frame
   
   get_tree().call_group("Persist", "before_load")
   for data in current_save.saved_data:
      var scene = load(data.path) as PackedScene
      var restored_node = scene.instantiate()
      if restored_node.has_method("after_load"): restored_node.after_load(data)
      get_node(data.parent).add_child(restored_node)
      #FIXME loaded cards do not change scene
   
   print_rich("[color=#64649E]SaveManager[/color]: game loaded")
