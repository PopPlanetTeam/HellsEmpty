extends Node2D
class_name ProjectileBase

signal hit

@export var speed : float = 500.0
@export var direction : Vector2 = Vector2.ZERO
@export var damage : float = 50.0

func get_damage() -> float:
	return damage

func set_damage(_damage: float) -> void:
	damage = _damage

func _ready():
	$DamageArea.damage = damage

func _physics_process(delta):
	self.position += speed * direction * delta

func _on_damage_area_body_entered(body):
	# If the projectile hits the TileMap, destroy it
	if (body is TileMap) or (PhysicsServer2D.body_get_collision_layer(body) == 1):
		hit.emit()

func _on_damage_area_damage_dealt():
	# If damage was dealt, then the projectile hit something
	hit.emit()

func _on_hit():
	# Delete the projectile when hit
	# If subclasses want another behavior, they can override this method
	queue_free()
