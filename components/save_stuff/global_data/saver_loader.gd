extends Node
class_name GlobalDataSaverLoader

const SAVE_PATH = "res://saves/general/global_data.tres"

signal save_complete
signal load_complete

func save_scene():
	var save = GlobalDataSave.new()
	
	save.total_enemies_killed = GlobalData.total_enemies_killed
	
	ResourceSaver.save(save, SAVE_PATH)
	
	save_complete.emit()

func load_scene():
	var save = load(SAVE_PATH) as GlobalDataSave

	if not save:
		print("No save found. Going with default values.")
		return
	
	GlobalData.total_enemies_killed = save.total_enemies_killed
	
	load_complete.emit()
