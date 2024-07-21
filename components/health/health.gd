extends Node2D
class_name Health

signal died

@export var life: float = 100.0 :
	set(value):
		life = value
	get:
		return life

@onready var _life_bar = $LifeBar

func _ready():
	_life_bar.max_value = life

func _process(delta):
	_life_bar.value = life

func take_damage(ammount:float) -> void:
	life -= ammount
	
	if life <= 0.0:
		died.emit()
	
func regenerate(ammount: float) -> void:
	life += ammount
