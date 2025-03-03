extends Node

# ---- # variables
var save_exists : bool = false

# ---- # Ready
func _ready():
   Signals.connect("save_game", save_game)
   Signals.connect("load_game", load_game)
   if FileAccess.file_exists("user://savegame.save"): save_exists = true

# ---- # Save Game
# saves all persistent game data and the current scene
func save_game():
   Signals.emit_signal("game_saved")
   save_exists = true
   var save_file := FileAccess.open("user://savegame.save", FileAccess.WRITE)
   var save_nodes : Array = get_tree().get_nodes_in_group("Persist")
   
   save_file.store_line(JSON.stringify({"scene_root": get_tree().current_scene.scene_file_path}))   # save the current scene
   save_file.store_line(JSON.stringify(Global.player_stats.save()))   # stringify and add player stats to the file
   
   for node in save_nodes:
      if node.scene_file_path.is_empty() or !node.has_method("save"):
         print_rich("[color=Crimson]Error[/color]: SaveManager cannot find save method")
         continue
      var json_data : String = JSON.stringify(node.save())
      save_file.store_line(json_data)
      
# ---- # Load Game
# loads all persistent game data, removes duplicates, and loads the saved scene
func load_game():
   print_rich("SaveManager: loading save file")
   if not FileAccess.file_exists("user://savegame.save"):
      print_rich("[color=Crimson]Error[/color]: SaveManager cannot find save file")
      return
   
   var save_file := FileAccess.open("user://savegame.save", FileAccess.READ)
   var first_line = json_get_line(save_file)
   
   var map
   var player
      
   if first_line.has("scene_root"):          # if line contains scene then load and skip
      map = get_tree().change_scene_to_file(first_line["scene_root"])
      await get_tree().process_frame
      await get_tree().process_frame
   
   var save_nodes : Array = get_tree().get_nodes_in_group("Persist")
   for node in save_nodes:
      node.queue_free()
      await get_tree().process_frame
      await get_tree().process_frame
      Global.update_groups()
   
   while save_file.get_position() < save_file.get_length():
      var data = json_get_line(save_file)
      
      if !data.has("type"): continue      # if line doesnt have type then skip
      if data["type"] == "resource":
         for i in data.keys():
            if i == "filename" or i == "type":
               continue
            Global.player_stats.set(i, data[i])
      elif data["type"] == "node":
         var new_object = load(data["filename"]).instantiate()
         get_node(data["parent"]).add_child(new_object)
         new_object.position = Vector2(data["position_x"], data["position_y"])
         new_object.rotation = data["rotation"]
         
         if !player and data["filename"] == "res://scenes/player.tscn": player = new_object
         
         # create the weapon --- update to use equip
         var new_weapon = load(data["weapon"]["filename"]).instantiate()
         new_object.weapon = new_weapon
         new_object.add_child(new_weapon)
         for i in data["weapon"]:
            if i == "filename" or i == "parent": continue
            new_object.weapon.set(i, data["weapon"][i])
      
         # set the remaining variables
         for i in data.keys():
            if i == "filename" or i == "type" or i == "parent" or i == "position_x" or i == "position_y" or i == "weapon" or i == "active_perks":
               continue
            new_object.set(i, data[i])
         if new_object.has_method("custom_load"): new_object.custom_load()
   Signals.emit_signal("map_loaded", map, player)

# ---- # JSON Get Line
func json_get_line(json_file):
   var json_data : String = json_file.get_line()
   var json : JSON = JSON.new()      # json helper class
      
   var parse_result := json.parse(json_data)
   if not parse_result == OK: print_rich("[color=Crimson]Error[/color]: SaveManager parse error")
   return json.data
