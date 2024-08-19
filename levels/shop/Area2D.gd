extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _select_to_buy(action):
	print(action)
	print("OK")

func _on_area_entered(area):
	set_process(true)
	#Input.connect("action_pressed", _select_to_buy)

func _on_area_exited(area):
	#Input.disconnect("action_pressed", _select_to_buy)
	set_process(false)

