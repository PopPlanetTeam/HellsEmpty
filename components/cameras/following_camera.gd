extends Camera2D
class_name FollowingCamera

## The camera will follow the player. This script should be attached to the camera node.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalData.player:
		self.global_position = GlobalData.player.global_position
