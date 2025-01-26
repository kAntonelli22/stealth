extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Global.instance_guard(self, [Vector2(200, 200)], 90)
   Global.instance_guard(self, [Vector2(300, 500)], 180)
   pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

# ---- # Issue List # -------------------------------------------------------- #
# - guard rotation goes the wrong way when on the far left
# - guard continues rotating after player leaves vision cone
# - guard does not continue rotating to the players last know location

# ---- # Issue List # -------------------------------------------------------- #

# ---- # Todo List # --------------------------------------------------------- #
# - add detection meters
# - add attack cooldown
# - add dash and stamina
# - add player shadow for chasing unseen players
# - add guard paths
# - add guard pathfinding
# - add guard weapons (knife, batton, pistol, shotgun, smg, rifle)
# - add player weapons (fists, knife, sword, pistol)
# - guard vision cones expand when alerted
# - weapon sprites and animations
# - entry and exit points
# - guard reinforce and vip exit points

# ---- # Todo List # --------------------------------------------------------- #
