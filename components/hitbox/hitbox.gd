extends Area2D
class_name HitBox

signal damage_taken(amount: float, knockback: Vector2)

@export var health_component: Health = null

func take_damage(ammount: float, knockback: Vector2):
	if health_component:
		health_component.take_damage(ammount)
		
		if health_component.life > 0.0:
			damage_taken.emit(ammount, knockback)
