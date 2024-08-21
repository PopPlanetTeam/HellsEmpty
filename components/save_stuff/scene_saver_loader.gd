extends Node
class_name SceneSaverLoader

var _root_node: Node

func _ready():
	_root_node = get_tree().get_root()

func save_scene():
	var save = DesertSave.new()
	
	var weapons_array: Array[WeaponSave] = []
	get_tree().call_group(GlobalData.WEAPON_SAVE_GROUP, "save", weapons_array)

	save.weapons = weapons_array
	ResourceSaver.save(save, "res://saves/map/desert_save.tres")

func load_scene():
	var save = load("res://saves/map/desert_save.tres") as DesertSave

	if not save:
		# print("No save found. Going with default values.")
		return
	
	var weapons = get_tree().get_nodes_in_group(GlobalData.WEAPON_SAVE_GROUP)

	for w in weapons:
		var weapon = save.weapons.any(func (x) -> bool:
			return x.node_name == w.name
		)

		if not weapon:
			# print("No weapon found for node: " + w.name)
			w.queue_free()
