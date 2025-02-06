extends Node2D
class_name Melee

# ---- # nodes # ---- #
@onready var holder : Node2D = get_parent()
@onready var sprite := $Sprite
@onready var hurtbox := $Hurtbox
@onready var directionbox := $DirectionBox
@onready var recharge_bar := $RechargeBar

# ---- # arrays # ---- #
var hurtbox_objects : Array = []
var directionbox_objects : Array = []

# ---- # weapon stats # ---- #
var damage : int = 10
var attack_speed : int
var cooldown : float = 1.5      # cooldown time before next attack
var recharge : float = 1.5      # current recharge time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
   recharge_bar.max_value = cooldown

func _process(delta: float) -> void:
   recharge += delta
   if recharge > cooldown: recharge = cooldown
   recharge_bar.value = recharge


func _on_hurtbox_entered(body: Node2D) -> void:
   print("melee: hurtbox entered by: ", body.type)
   hurtbox_objects.append(body)

func _on_hurtbox_exited(body: Node2D) -> void:
   print("melee: hurtbox exited by: ", body.type)
   hurtbox_objects.remove_at(hurtbox_objects.find(body))

func _on_direction_box_entered(body: Node2D) -> void:
   print("melee: directionbox entered by: ", body.type)
   directionbox_objects.append(body)

func _on_direction_box_exited(body: Node2D) -> void:
   print("melee: directionbox exited by: ", body.type)
   directionbox_objects.remove_at(directionbox_objects.find(body))

# ---- # attack function called by holder when it wants to attack # ---------- # 
func attack():
   recharge = 0
   for object in hurtbox_objects:
      if object != holder and directionbox_objects.has(object):
         object.hit(holder, self, damage)
         print("melee: ", object.type, " hit for ", damage, " damage")

# ---- # can hit function called to check if something can be hit by ai # ---- #
func can_hit(object : CharacterBody2D) -> bool:
   if directionbox_objects.has(object) and hurtbox_objects.has(object): return true
   else: return false
