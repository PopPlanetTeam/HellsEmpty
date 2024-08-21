extends Node2D
class_name SceneBase

@export var player_spawn_markers: Node

func _ready():
	if SceneManager.player_transition:
		_spawn_player()

func _spawn_player():
	var scene_from = SceneManager.last_scene

	if scene_from.is_empty():
		scene_from = "any"

	var marker = player_spawn_markers.get_node(scene_from)

	if not marker:
		printerr("No spawn marker found for scene: " + scene_from)
		get_tree().quit()
		return
	
	var player = SceneManager.player_transition

	add_child(player)
	player.global_position = marker.global_position

	# Removing first spawned player from scene
	if GlobalData.player != player:
		var previous_player = GlobalData.player
		GlobalData.player = player
		previous_player.queue_free()

func _on_player_died():
	print("Player died")
	print("Enemies killed: ", GlobalData.enemies_killed)
	
	get_tree().quit()