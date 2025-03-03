extends Node2D
class_name Weapon

# ---- # nodes
@onready var sprite := $Sprite
@onready var hurtbox := $Hurtbox
@onready var directionbox := $DirectionBox
@onready var recharge_bar := $RechargeBar

# ---- # arrays
var hurtbox_objects : Array = []
var directionbox_objects : Array = []

# ---- # weapon stats
var damage : int = 10
var attack_speed : int
var cooldown : float = 1.5      # cooldown time before next attack
var recharge : float = 1.5      # current recharge time

# ---- # Ready
func _ready() -> void:
   recharge_bar.max_value = cooldown

# ---- # Process
func _process(delta: float) -> void:
   recharge += delta
   if recharge > cooldown: recharge = cooldown
   recharge_bar.value = recharge

# ---- # Hurtbox Entered and Exited
func _on_hurtbox_entered(body: Node2D) -> void: hurtbox_objects.append(body)
func _on_hurtbox_exited(body: Node2D) -> void:
   hurtbox_objects.remove_at(hurtbox_objects.find(body))

# ---- # Directionbox Entered and Exited
func _on_direction_box_entered(body: Node2D) -> void: directionbox_objects.append(body)
func _on_direction_box_exited(body: Node2D) -> void:
   directionbox_objects.remove_at(directionbox_objects.find(body))

# ---- # Attack
# calls the attack function on all bodies in the hurtbox and directionbox
func attack(holder: CharacterBody2D):
   recharge = 0
   for object in hurtbox_objects:
      if object != holder and directionbox_objects.has(object):
         object.hit(holder, self, damage)

# ---- # Can Hit
func can_hit(object : CharacterBody2D) -> bool:
   if directionbox_objects.has(object) and hurtbox_objects.has(object): return true
   else: return false

# ---- # Equip
# called to load the weapon as a child of the holder
static func equip(holder: CharacterBody2D):
   var slot = holder.weapon_slot
   if slot.get_children():
      for weapon in slot.get_children():
         weapon.queue_free()

# ---- # Save
func save() -> Dictionary:
   var save_dict = {
      "filename": get_scene_file_path(),
      "damage": damage,
      "attack_speed": attack_speed,
      "cooldown": cooldown,
      "recharge": recharge,
   }
   return save_dict
