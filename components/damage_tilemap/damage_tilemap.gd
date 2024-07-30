extends TileMap
class_name DamageTileMap

@export var damage_amount: float = 1.0
@export var knockback_strength: float = 10.0

const _DAMAGE_GROUP = "damage_body"

func _ready():
	self.add_to_group(_DAMAGE_GROUP)

func get_damage() -> float:
	return damage_amount

func get_knockback(target_position: Vector2) -> Vector2:
	var direction = (target_position - self.global_position).normalized()
	var knockback = direction * knockback_strength
	return knockback
