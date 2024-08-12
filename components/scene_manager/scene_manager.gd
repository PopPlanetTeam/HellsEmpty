extends Node

var last_scene: String
var player_transition: PlayerBase

func change_scene(from: Node, to: String) -> void:
	last_scene = from.name
	
	# Remove player from the scene, so it doesn't get destroyed when changing scenes
	player_transition = GlobalData.player
	from.remove_child(player_transition)

	print("Player: " + player_transition.name + " removed from scene: " + from.name)

	from.get_tree().call_deferred("change_scene_to_file", to)
	
