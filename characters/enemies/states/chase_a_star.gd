extends State

signal player_too_far
signal player_next_to_enemy

@export var navigation_agent: NavigationAgent2D
@export_range(0, 1) var smooth_factor: float = 0.05
@export var debug: bool = false

var _enemy: EnemyBase
var _player: PlayerBase
var _run_away_distance: float
var _distance_to_attack: float

## This function is automatically called when the state is entered.
func Enter():
	if not navigation_agent:
		printerr("ChaseState> this state requires a NavigationAgent2D to be set.")
		get_tree().quit()

	_enemy = state_machine.get_parent()
	_run_away_distance = _enemy.run_away_distance
	_distance_to_attack = _enemy.distance_to_attack

## This function is automatically called when the state is exited.
func Exit():
	pass

func _physics_process(_delta):
	_player = GlobalData.player

	if _player:
		var distance = _enemy.global_position.distance_to(_player.global_position)
		
		if debug:
			print("Distance to player: ", distance)

		if distance >= _run_away_distance:
			player_too_far.emit()
			return
		
		if distance <= _distance_to_attack:
			player_next_to_enemy.emit()
			return
		
		# Calculates the direction and velocity towards the player
		navigation_agent.target_position = _player.global_position
		var direction = _enemy.global_position.direction_to(navigation_agent.get_next_path_position()).normalized()
		_enemy.velocity = _enemy.velocity.lerp(direction * _enemy.speed, smooth_factor)
		
		# Animates the enemy
		_enemy.animation_sprites.play("run")
		_enemy.animation_sprites.flip_h = direction.x < 0
		
		# Move the enemy
		_enemy.move_and_slide()
		
	else:
		player_too_far.emit()
