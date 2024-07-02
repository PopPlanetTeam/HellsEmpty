extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get mouse coords
	var mouse_cords = get_local_mouse_position()
	var angle = mouse_cords.angle()
	
	$Arm.rotation = angle
	$ColorRect.rotation = angle
	#self.rotate(angle)
	#self.rotate(angle)
	
