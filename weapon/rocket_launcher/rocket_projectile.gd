extends Node2D
class_name RocketProjectile

@export var speed : float = 0.0
@export var direction : Vector2 = Vector2.ZERO
@export var damage : float = 0.0

func _ready():
	pass

func _on_hitbox_area_entered(area):
	if area is HitBox:
		var hitbox:HitBox = area
		hitbox.take_damage(damage)

func _process(delta):
	position += speed * direction * delta
