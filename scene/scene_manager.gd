extends Node

var last_scene: String
var player_transition: PlayerBase
var keep_global_audio_playing: bool = false

func change_scene_packed(from: Node, to: PackedScene, d: bool = false) -> void:
	last_scene = from.name
	keep_global_audio_playing = d
	
	# Remove player from the scene, so it doesn't get destroyed when changing scenes
	player_transition = GlobalData.player
	from.remove_child(player_transition)

	FadeTransition.transition()
	await FadeTransition.transition_finished

	from.get_tree().call_deferred("change_scene_to_packed", to)
	
func transition_happened() -> bool:
	return last_scene != ""
