extends Node2D
class_name Health

signal died

@export var life: float = 100.0 :
	set(value):
		life = value
	get:
		return life

func take_damage(ammount:float) -> void:
	life -= ammount
	
	if life < 0.0:
		died.emit()
		get_parent().queue_free()
	
func regenerate(ammount: float) -> void:
	life += ammount
