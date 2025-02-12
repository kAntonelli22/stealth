extends Weapon
class_name Melee

# ---- # Ready
func _ready() -> void:
   super()

# ---- # Equip
# called by character nodes when they want to equip the weapon
static func equip(holder: CharacterBody2D):
   super(holder)
   var weapon = load("res://scenes/melee.tscn").instantiate()
   holder.weapon = weapon
   holder.add_child(weapon)

# ---- # Process
func _process(delta: float) -> void:
   super(delta)
