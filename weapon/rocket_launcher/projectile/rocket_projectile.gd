extends ProjectileBase
class_name RocketProjectile

var _explosion_scene = preload("res://effects/explosion.tscn")

@onready var _damage_area_shape = $DamageArea/CollisionShape2D
@onready var _sprite = $Sprite2D

func _on_hit():
	self.speed = 0
	_sprite.visible = false

	var explosion = _explosion_scene.instantiate()

	explosion.global_position = self.global_position
	get_parent().add_child(explosion)

	# Increase area of damage
	var amount = 10
	_damage_area_shape.scale = Vector2(amount, amount)

	await get_tree().create_timer(1.0).timeout

	self.queue_free()
