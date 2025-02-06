extends Resource
class_name Perk

var name : String
var description : String
#var icon : Resource
var type : String


# Called when the node enters the scene tree for the first time.
func _init(name: String = "Perk", description: String = "description", 
type: String = "Boost") -> void:
   self.name = name
   self.description = description
   #self.icon = icon
   self.type = type

func apply_perk(player: CharacterBody2D):
   print("perk ", name, " does not have an application function")

class BoostPerk extends Perk:
   var boost_percent : float
   
   func _init(name: String, description: String, type: String, boost_percent: float = .10) -> void:
      super(name, description, type)
      self.boost_percent = boost_percent

class SpeedPerk extends BoostPerk:
   func apply_perk(player: CharacterBody2D): player.speed += player.speed * boost_percent

class HealthPerk extends BoostPerk:
   func apply_perk(player: CharacterBody2D): player.health += player.health * boost_percent

class StrengthPerk extends BoostPerk:
   func apply_perk(player: CharacterBody2D): player.speed += player.speed * boost_percent
