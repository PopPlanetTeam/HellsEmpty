extends Node
class_name Health

@export var life: float = 100.0 :
	set(value):
		life = value
	get:
		return life

func take_damage(ammount:float) -> void:
	life -= ammount
	
func regenerate(ammount: float) -> void:
	life += ammount
