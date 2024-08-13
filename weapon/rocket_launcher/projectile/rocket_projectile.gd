extends ProjectileBase
class_name RocketProjectile

var _explosion_scene = preload("res://effects/explosion.tscn")

func _on_hit():
	var explosion = _explosion_scene.instantiate()

	explosion.global_position = self.global_position
	get_parent().add_child(explosion)

	self.queue_free()
