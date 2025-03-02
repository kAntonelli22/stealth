extends Node

# ---- # SaveManager signals
signal save_game
signal load_game
signal game_saved
signal map_loaded(map: Node2D, player: CharacterBody2D)

# ---- # scene signals
signal map_changed
signal contract_over(player_died: bool)       # emitted when the player wins or loses a contract

# ---- # ui signals
signal new_entrance(entrance: Node2D)        # emitted by entrance when it is instanced for ui

# ---- # character body signals
signal update_attributes(health: int)        # emitted by player for ui when health changes
signal target_dead(target: CharacterBody2D, weapon: Node2D)       # emitted when a target dies
signal guard_dead(guard: CharacterBody2D, weapon: Node2D)         # emitted when a guard dies
