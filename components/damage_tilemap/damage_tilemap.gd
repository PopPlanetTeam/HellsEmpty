extends TileMap
class_name DamageTileMap

@export var damage_amount: float = 1.0
@export var knockback_strength: float = 10.0

@export_flags_2d_physics var provides_damage = 0

func _ready():
	self.add_to_group(GlobalData.DAMAGE_GROUP)
	self.tile_set.set_physics_layer_collision_layer(0, self.tile_set.get_physics_layer_collision_layer(0) | provides_damage)

func get_damage() -> float:
	return damage_amount

func get_knockback(target_position: Vector2) -> Vector2:
	var direction = (target_position - self.global_position).normalized()
	var knockback = direction * knockback_strength
	return knockback
