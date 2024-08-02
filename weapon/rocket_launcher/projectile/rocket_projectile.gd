extends Node2D
class_name RocketProjectile

@export var speed : float = 500.0
@export var direction : Vector2 = Vector2.ZERO
@export var damage : float = 50.0

var _explosion_scene = preload("res://effects/explosion.tscn")

func _ready():
	$DamageArea.damage = damage

func _process(delta):
	position += speed * direction * delta

func _on_damage_area_damage_dealt():
	var explosion = _explosion_scene.instantiate()

	explosion.global_position = self.global_position
	get_parent().add_child(explosion)

	self.queue_free()
