extends Resource
class_name EnemieSave

@export var life: float
@export var global_position: Vector2
@export var scene_path: String

func _init():
	life = 0.0
	global_position = Vector2.ZERO
	scene_path = ""