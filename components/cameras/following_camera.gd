extends Camera2D
class_name FollowingCamera

@export var player_spawns: Node

## The camera will follow the player. This script should be attached to the camera node.

func _ready():
	if SceneManager.transition_happened():
		# If the scene is being loaded, we want the camera to be positioned at the player's spawn point.
		self.global_position = player_spawns.get_node(SceneManager.last_scene).global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalData.player:
		self.global_position = GlobalData.player.global_position
