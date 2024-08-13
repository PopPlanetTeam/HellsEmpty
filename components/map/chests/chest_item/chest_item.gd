extends Resource
class_name ChestItem

@export var item_scene: PackedScene
@export var number_of_items: int = 1

func _init():
	item_scene = null
	number_of_items = 1
