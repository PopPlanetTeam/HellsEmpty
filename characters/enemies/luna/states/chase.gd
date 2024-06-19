extends State

@onready var _enemy = $"../.."

## This function is automatically called when the state is entered.
func Enter():
	get_tree().create_timer(1.0).timeout.connect(_on_timeout)

## This function is automatically called when the state is exited.
func Exit():
	pass

func _on_timeout():
	state_machine.change_to_state(self, "idle")

func _physics_process(delta):
	_enemy.velocity = Vector2(-1, 0) * _enemy.speed

	_enemy.move_and_slide()
