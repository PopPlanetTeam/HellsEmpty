extends State

signal player_too_far

var _enemy: EnemyBase
var _player: PlayerBase
var _distance_threshold

## This function is automatically called when the state is entered.
func Enter():
	_enemy = state_machine.get_parent()
	_distance_threshold = _enemy.distance_threshold

## This function is automatically called when the state is exited.
func Exit():
	pass

func _physics_process(_delta):
	_player = GlobalData.player

	if _player:
		var distance = _enemy.global_position.distance_to(_player.global_position)

		if distance > _distance_threshold:
			player_too_far.emit()

		# Get direction
		var direction = _player.global_position - _enemy.global_position
		# Normalize it
		direction = direction.normalized()

		_enemy.velocity = direction * _enemy.speed
		_enemy.move_and_slide()
