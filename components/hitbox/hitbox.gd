extends Area2D
class_name HitBox

@export var health_component: Health = null

func take_damage(ammount: float):
	if health_component:
		health_component.take_damage(ammount)
