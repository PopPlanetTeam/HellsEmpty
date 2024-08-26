extends Node
class_name PlayerInventorySaverLoader

signal save_complete
signal load_complete

const SAVE_PATH = "user://saves/player/inventory.tres"

func save_scene():
	var save = PlayerInventorySave.new()
	
	save.coins_ammount = PlayerInventory.coins_amount
	save.unlocked_weapons = PlayerInventory.unlocked_weapons
	save.current_weapon = load(PlayerInventory.current_weapon.scene_file_path)
	
	ResourceSaver.save(save, SAVE_PATH)
	
	save_complete.emit()

func load_scene():
	var save = load(SAVE_PATH) as PlayerInventorySave

	if not save:
		print("No save found. Going with default values.")
		PlayerInventory.current_weapon = null
		return
	
	PlayerInventory.coins_amount = save.coins_ammount
	PlayerInventory.unlocked_weapons = save.unlocked_weapons
	PlayerInventory.current_weapon = save.current_weapon.instantiate()
	
	load_complete.emit()
