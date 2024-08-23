extends Area2D
class_name ScenePortal

@export var scene_to_go_path: String
@export var saver_loader: SceneSaverLoader

var _destinity: PackedScene

func _ready():
	if scene_to_go_path.is_empty():
		printerr("Scene Portal> No scene to go path defined. Deleting node.")
		queue_free()
		return
	
	if not saver_loader:
		printerr("Scene Portal> No SceneSaverLoader defined. Deleting node.")
		queue_free()
		return

	_destinity = load(scene_to_go_path) as PackedScene

func set_enabled(enabled: bool) -> void:
	self.monitoring = enabled

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is PlayerBase:
		# Save current scene before transition
		saver_loader.save_scene()
		if not saver_loader.save_completed:
			await saver_loader.save_complete
		
		# Update total enemies killed
		GlobalData.total_enemies_killed += GlobalData.level_enemies_killed	
		
		SceneManager.change_scene_packed(get_tree().current_scene, _destinity)
