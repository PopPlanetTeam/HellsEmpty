extends Node2D
class_name SceneBase

@export var player_spawn_markers: Node

func _ready():
	_spawn_player()

func _spawn_player():
	var scene_from = SceneManager.last_scene

	if scene_from.is_empty():
		scene_from = "any"

	var marker = player_spawn_markers.get_node(scene_from)

	if not marker:
		printerr("No spawn marker found for scene: " + scene_from)
		get_tree().quit()
	
	var player = GlobalData.player

	if not player:
		printerr("No player found in GlobalData")
		get_tree().quit()

	if not player.is_inside_tree():
		add_child(player)

	player.global_position = marker.global_position
