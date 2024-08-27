extends Area2D

@export var desert_scene: String
@export var keep_global_audio_playing: bool = false

var _desert_pscene: PackedScene

func _ready():
	_desert_pscene = load(desert_scene) as PackedScene
	SceneManager.keep_global_audio_playing = keep_global_audio_playing

func _on_area_entered(area):
	if area.get_parent() is PlayerBase:
		SceneManager.change_scene_packed(get_tree().current_scene, _desert_pscene, keep_global_audio_playing)
