extends Node
class_name PlayerInventorySaverLoader

var _root_node: Node

func _ready():
	_root_node = get_tree().get_root()

func save_scene():
	var save = PlayerInventorySave.new()
	
	save.coins_ammount = PlayerInventory.coins_amount
	save.unlocked_weapons = PlayerInventory.unlocked_weapons
	save.current_weapon = load(PlayerInventory.current_weapon.scene_file_path)
	# var packed_scene_weapon = PackedScene.new()
	# packed_scene_weapon.pack(PlayerInventory.current_weapon)
	# save.current_weapon = packed_scene_weapon
	
	ResourceSaver.save(save, "res://saves/player/inventory.tres")

func load_scene():
	var save = load("res://saves/player/inventory.tres") as PlayerInventorySave

	if not save:
		print("No save found. Going with default values.")
		PlayerInventory.current_weapon = null
		return
	
	PlayerInventory.coins_amount = save.coins_ammount
	PlayerInventory.unlocked_weapons = save.unlocked_weapons
	PlayerInventory.current_weapon = save.current_weapon.instantiate()
