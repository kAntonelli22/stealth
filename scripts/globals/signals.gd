extends Node

# ---- # SaveManager signals # ---- #
signal save_game
signal load_game
signal game_saved

# ---- # scene signals # ---- #
signal map_changed

# ---- # character body signals # ---- #
signal update_attributes(health : int)       # emmited by player for ui when health changes
signal target_dead(target : CharacterBody2D, weapon : Node2D)     # emitted when a target dies
signal guard_dead(guard : CharacterBody2D, weapon : Node2D)       # emitted when a guard dies
