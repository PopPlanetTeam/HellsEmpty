extends Node2D
class_name SceneBase

@export var player_spawn_markers: Node
@export var enemies_spawner: EnemySpawner
@export var saver_loader: SceneSaverLoader

func _ready():
	if SceneManager.transition_happened():
		_spawn_player()

		pause_for_transition()
		
		saver_loader.load_scene()
		if not saver_loader.load_completed:
			await(saver_loader.load_complete)
		
		resume_after_transition()
	else:
		_new_scene()

## Here we put everything that should happen when the player enters the scene for the first time.
## It's stuff that needs to be GENERATED and later LOADED when the player comes back to the scene.
func _new_scene():
	pass

# Pause for scene transition
func pause_for_transition():
	# Pause player
	GlobalData.player.process_mode = Node.PROCESS_MODE_DISABLED
	# Pause enemies
	if enemies_spawner:
		enemies_spawner.process_mode = Node.PROCESS_MODE_DISABLED

# Resume after scene transition
func resume_after_transition():
	# Resume player
	GlobalData.player.process_mode = Node.PROCESS_MODE_INHERIT
	# Resume enemies
	if enemies_spawner:
		enemies_spawner.process_mode = Node.PROCESS_MODE_INHERIT

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
	print("Enemies killed: ", GlobalData.level_enemies_killed)
	
	get_tree().quit()
