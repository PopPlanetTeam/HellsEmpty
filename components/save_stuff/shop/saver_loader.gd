extends Node
class_name ShopSaverLoader

signal save_complete
signal load_complete

const SAVE_PATH = "user://forest.tres"

func save_scene():
	var save = ShopSave.new()
	
	save.unlocked_forest = Shop.forest_unlocked

	ResourceSaver.save(save, SAVE_PATH)

func load_scene():
	var save = load(SAVE_PATH) as ShopSave

	if not save:
		print("No save found. Going with default values.")
		return
	
	Shop.forest_unlocked = save.unlocked_forest
