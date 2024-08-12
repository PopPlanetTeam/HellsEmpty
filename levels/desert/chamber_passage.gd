extends Area2D

@export var chamber_scene: String

func _on_area_entered(area):
	if area.get_parent()  is PlayerBase:
		SceneManager.change_scene(get_tree().current_scene, chamber_scene)
