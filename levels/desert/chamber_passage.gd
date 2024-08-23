extends Area2D

@export var chamber_scene: String

@onready var saver_loader: SceneSaverLoader = $"../SceneSaverLoader"

var _chamber_pscene: PackedScene

func _ready():
	_chamber_pscene = load(chamber_scene) as PackedScene

func _on_area_entered(area):
	if area.get_parent()  is PlayerBase:

		get_parent().pause_for_transition()

		saver_loader.save_scene()
		if not saver_loader.save_completed:
			await saver_loader.save_complete
		
		get_parent().resume_after_transition()

		SceneManager.change_scene_packed(get_tree().current_scene, _chamber_pscene)
