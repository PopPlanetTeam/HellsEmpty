extends Resource
class_name DropItem

@export var item_scene: PackedScene
@export var min_amount: int = 1
@export var max_amount: int = 2
@export var probability: float = 0.5

func _init():
	item_scene = null
	min_amount = 1
	max_amount = 2
	probability = 0.5
