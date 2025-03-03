extends Resource
class_name Perk

# ---- # variables
var name : String
var description : String
#var icon : Resource
var type : String


# ---- # Perk Initializer
func _init(p_name: String = "Perk", p_description: String = "description", 
p_type: String = "Boost") -> void:
   name = p_name
   description = p_description
   #icon = p_icon
   type = p_type

# ---- # Apply Perk
func apply_perk(player: CharacterBody2D): pass

# ---- # Save
func save() -> Dictionary:
   return {"name": name, "description": description, "type": type}

# ---- # BoostPerk
class BoostPerk extends Perk:
   # ---- # variables
   var boost_percent : float
   
   # ---- # BoostPerk Initializer
   func _init(p_name: String, p_description: String, p_type: String, p_boost_percent: float = .10) -> void:
      super(p_name, p_description, p_type)
      self.boost_percent = p_boost_percent
   
   # ---- # Save
   func save() -> Dictionary:
      return {"name": name, "description": description, "type": type, "boost_percent": boost_percent}

# ---- # SpeedPerk
class SpeedPerk extends BoostPerk:
   # ---- # SpeedPerk Initializer
   func _init(p_name: String = "Speed Perk", p_description: String = "increases the players speed",
   p_type: String = "Boost") -> void: super(p_name, p_description, p_type)
   
   # ---- # Apply Perk
   func apply_perk(player: CharacterBody2D): player.speed += player.speed * boost_percent

# ---- # HealthPerk
class HealthPerk extends BoostPerk:
   # ---- # HealthPerk Initializer
   func _init(p_name: String = "Health Perk", p_description: String = "increases the players health",
   p_type: String = "Boost") -> void: super(p_name, p_description, p_type)
   
   # ---- # Apply Perk
   func apply_perk(player: CharacterBody2D): player.health += player.health * boost_percent

# ---- # StrengthPerk
class StrengthPerk extends BoostPerk:
   # ---- # StrengthPerk Initializer
   func _init(p_name: String = "Strength Perk", p_description: String = "increases the players strength",
   p_type: String = "Boost") -> void: super(p_name, p_description, p_type)
   
   # ---- # Apply Perk
   func apply_perk(player: CharacterBody2D): player.speed += player.speed * boost_percent
