extends SceneBase

@onready var camera : Camera2D = $Camera2D

func _ready():
	super._ready()
	#var cam = SceneManager.player_transition.get_node("Camera2D") as Camera2D
	#SwitchNodes.transfer_all_children_added_on_this_scene(cam, camera)
	##remove_child(camera)
	#SceneManager.player_transition.remove_child(cam)
	#SceneManager.player_transition.add_child(camera)
	
	
