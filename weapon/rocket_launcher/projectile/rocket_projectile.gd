extends Node2D
class_name RocketProjectile

@export var speed : float = 500.0
@export var direction : Vector2 = Vector2.ZERO
@export var damage : float = 50.0

func _ready():
	$DamageArea.damage = damage

func _process(delta):
	position += speed * direction * delta

func _on_damage_area_damage_dealt():
	self.queue_free()
