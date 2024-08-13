extends Area2D

@export var chamber_scene: String

@onready var saver_loader: SceneSaverLoader = $"../SceneSaverLoader"

func _on_area_entered(area):
	if area.get_parent()  is PlayerBase:
		saver_loader.save_scene()
		SceneManager.change_scene(get_tree().current_scene, chamber_scene)
