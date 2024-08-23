extends Resource
class_name ChestSave

@export var node_name: StringName
@export var is_open: bool

func _init():
	node_name = ""
	is_open = false