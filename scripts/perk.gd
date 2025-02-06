extends Resource
class_name Perk

@export_group("Visual")
@export var name : String
@export var description : String
#@export var icon : Resource
@export var type : String


# Called when the node enters the scene tree for the first time.
func _init(name: String = "Perk", description: String = "description", 
type: String = "Boost") -> void:
   self.name = name
   self.description = description
   #self.icon = icon
   self.type = type

func apply_perk(player: CharacterBody2D):
   print("applying ", name, " to ", player.name)

class BoostPerk:
   @export var boost_percent : float
   
   func _init(boost_percent: float = .10) -> void:
      self.boost_percent = boost_percent

class SpeedPerk extends BoostPerk:
   
   func apply_perk(player: CharacterBody2D):
      player.speed += player.speed * boost_percent
      print("boosting ", player.name, " speed to ", player.speed)
