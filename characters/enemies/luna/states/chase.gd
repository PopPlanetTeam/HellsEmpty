extends State

signal player_too_far

@export_range(0, 1) var smooth_factor: float = 0.1
@export var debug: bool = false

var _enemy: EnemyBase
var _player: PlayerBase
var _distance_threshold
var _possible_directions = [Vector2( - 1, 0), Vector2( - 1, 1), Vector2(0, 1), Vector2(1, 1), Vector2(1, 0), Vector2(1, -1), Vector2(0, -1), Vector2( - 1, -1)]

## This function is automatically called when the state is entered.
func Enter():
	_enemy = state_machine.get_parent()
	_distance_threshold = _enemy.distance_threshold

	# Normalize all possible directions
	for i in range(_possible_directions.size()):
		_possible_directions[i] = _possible_directions[i].normalized()

## This function is automatically called when the state is exited.
func Exit():
	pass

## Function that returns the index of the greatest value in an array.
## We used this instead of the built-in find(max()) because it's faster (O(n) vs O(2n)).
func _get_max_index(array: Array) -> int:
	var max_val = array[0]
	var max_index = 0

	for i in range(1, array.size()):
		if array[i] > max_val:
			max_val = array[i]
			max_index = i

	return max_index

func _physics_process(_delta):
	_player = GlobalData.player

	if _player:
		var distance = _enemy.global_position.distance_to(_player.global_position)

		if distance > _distance_threshold:
			player_too_far.emit()

		# Get direction
		var direction = _player.global_position - _enemy.global_position
		# Normalize direction
		var normalized_direction = direction.normalized()

		# Creating interest array with the dot product of possible directions
		var interest_array = []
		for i in range(_possible_directions.size()):
			var dot = normalized_direction.dot(_possible_directions[i])
			interest_array.append(dot)
		
		# Get the danger array
		var danger_array = _enemy.obstacle_detector.get_danger_array()
		# Subtract from the interest the danger array
		var context_map_array = Utils.subtract_arrays(interest_array, danger_array)
		
		if debug:
			print("Chase State> ------------------------------ ")
			print("Chase State> Desired direction: ", normalized_direction)
			print("Chase State> Interest array: ", Utils.format_array(interest_array, "%.2f"))
			print("Chase State> Context map array: ", Utils.format_array(context_map_array, "%.2f"))

		# Get the index of the highest interest
		var max_index = _get_max_index(context_map_array)
		# Get the direction with the highest interest
		var direction_to_player = _possible_directions[max_index]

		# Smooth the movement using linear interpolation
		var current_direction = _enemy.velocity.normalized()
		var new_direction = current_direction.lerp(direction_to_player, smooth_factor).normalized()

		# Move the enemy
		_enemy.velocity = new_direction * _enemy.speed
		_enemy.move_and_slide()
