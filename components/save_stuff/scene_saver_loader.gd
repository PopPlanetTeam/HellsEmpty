extends Node
class_name SceneSaverLoader

var _root_node: Node
var _scene_save_file: String
var _save_path: String

func _ready():
	_root_node = get_tree().current_scene
	_scene_save_file = _root_node.scene_file_path.get_file().get_basename() + "_save.tres"
	_save_path = "res://saves/map/" + _scene_save_file

func save_scene():
	var save = SceneSave.new()
	
	# Saving Weapons
	var weapons_array: Array[WeaponSave] = []
	get_tree().call_group(GlobalData.WEAPON_SAVE_GROUP, "save", weapons_array)
	save.weapons = weapons_array

	ResourceSaver.save(save, _save_path)

func load_scene():
	if FileAccess.file_exists(_save_path):
		var save = load(_save_path) as SceneSave

		var weapons = get_tree().get_nodes_in_group(GlobalData.WEAPON_SAVE_GROUP)

		for w in weapons:
			var weapon = save.weapons.any(func (x) -> bool:
				return x.node_name == w.name
			)

			if not weapon:
				# print("No weapon found for node: " + w.name)
				w.queue_free()
