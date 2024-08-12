extends Node

var last_scene: String

func change_scene(from: Node, to: String) -> void:
	last_scene = from.name
	
	# Remove player from the scene, so it doesn't get destroyed when changing scenes
	var player = GlobalData.player
	from.remove_child(player)

	from.get_tree().call_deferred("change_scene_to_file", to)
	
