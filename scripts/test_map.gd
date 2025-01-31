extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   Global.instance_guard(self, [Vector2(200, 200)], 90)
   Global.instance_guard(self, [Vector2(600, 400)], 180)
   Global.instance_target(self, [Vector2(400, 400)], 180)
   pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
   pass

# ---- # Issue List # -------------------------------------------------------- #
# - guard does not continue rotating to the players last know location

# ---- # Issue List # -------------------------------------------------------- #

# ---- # Todo List # --------------------------------------------------------- #
# - add player shadow in guard scenes for chasing unseen players
# - add guard paths
# - add guard pathfinding
# - add guard weapons (knife, batton, pistol, shotgun, smg, rifle)
# - add player weapons (fists, knife, sword, pistol)
# - guard vision cones expand when alerted
# - weapon sprites and animations
# - entry and exit points
# - guard reinforce and vip exit points
# - dash increases detection

# ---- # Todo List # --------------------------------------------------------- #
