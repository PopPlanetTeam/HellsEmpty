extends Resource
class_name SceneSave

@export var weapons: Array[WeaponSave]
@export var chests: Array[ChestSave]
@export var enemies_spawner: Dictionary

func _init():
	weapons = []
	chests = []
	enemies_spawner = {
		"spawner_disable": false,
		"enemies": []
	}