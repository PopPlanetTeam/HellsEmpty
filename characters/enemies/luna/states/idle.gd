extends State

@onready var _animation = %Animation

## This function is automatically called when the state is entered.
func Enter():
	_animation.play("idle")

## This function is automatically called when the state is exited.
func Exit():
	pass
