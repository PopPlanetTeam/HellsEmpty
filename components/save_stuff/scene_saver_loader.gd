extends Node
class_name SceneSaverLoader

signal save_complete
signal load_complete

var save_completed = false
var load_completed = false

var _root_node: Node
var _scene_save_file: String
var _save_path: String

func _ready():
	self.process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS

	_root_node = get_tree().current_scene
	_scene_save_file = _root_node.scene_file_path.get_file().get_basename() + "_save.tres"
	_save_path = "res://saves/map/" + _scene_save_file

func save_scene():
	save_completed = false

	var save = SceneSave.new()
	
	# Saving Weapons picks
	var weapons_array: Array[WeaponSave] = []
	get_tree().call_group(GlobalData.WEAPON_SAVE_GROUP, "save", weapons_array)
	save.weapons = weapons_array

	# Saving Chests
	var chests_array: Array[ChestSave] = []
	get_tree().call_group(GlobalData.CHEST_SAVE_GROUP, "save", chests_array)
	save.chests = chests_array

	# Saving enemies
	var enemies_dict: Dictionary
	get_tree().call_group(GlobalData.ENEMY_SPAWN_GROUP, "save", enemies_dict)
	save.enemies_spawner = enemies_dict
	
	ResourceSaver.save(save, _save_path)

	save_complete.emit()

	save_completed = true


func load_scene():
	load_completed = false

	if FileAccess.file_exists(_save_path):
		var save = load(_save_path) as SceneSave

		# Loading Weapons
		var weapons = get_tree().get_nodes_in_group(GlobalData.WEAPON_SAVE_GROUP)
		for w in weapons:
			var weapon = save.weapons.any(func (x) -> bool:
				return x.node_name == w.name
			)

			if not weapon:
				# print("No weapon found for node: " + w.name)
				w.queue_free()

		# Loading Chests
		var chest_group_node = get_tree().get_first_node_in_group(GlobalData.CHEST_SAVE_GROUP)
		if chest_group_node:
			chest_group_node.call_deferred("load", save.chests)

		# Loading enemies
		var enemy_spawner = get_tree().get_first_node_in_group(GlobalData.ENEMY_SPAWN_GROUP)
		if enemy_spawner:
			enemy_spawner.call_deferred("load", save.enemies_spawner)
		
		load_complete.emit()
	
	load_completed = true
