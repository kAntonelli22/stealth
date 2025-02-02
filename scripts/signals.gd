extends Node

# ---- # scene signals # ---- #
signal map_changed

# ---- # character body signals # ---- #
signal update_attributes(health : int)       # emmited by player for ui when health changes
signal target_dead(target : CharacterBody2D, weapon : Node2D)     # emitted when a target dies
signal guard_dead(guard : CharacterBody2D, weapon : Node2D)       # emitted when a guard dies
signal player_dead(player : CharacterBody2D, weapon : Node2D)     # emitted when the player dies

signal noise(location : Vector2, alertness : int)     # emitted when a noise is made, alertness is for guard reactions
