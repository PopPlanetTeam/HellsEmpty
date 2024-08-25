extends Camera2D
class_name FollowingCamera

@export var player_spawns: Node

## The camera will follow the player. This script should be attached to the camera node.

func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalData.player != null:
		self.global_position = GlobalData.player.global_position
