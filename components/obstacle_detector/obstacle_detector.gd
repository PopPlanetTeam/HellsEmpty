extends Node2D
class_name ObstacleDetector

@export var debug: bool = false
@export var max_obstacle_danger: float = 1.0
@export_flags_2d_physics var collision_mask: int = 0:
	set(value):
		for ray in _rays:
			ray.collision_mask = value

var _rays: Array
var _danger_array: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	_rays = self.get_children()

	if _rays.size() != 8:
		printerr("ObstacleDetector> Raycast2D children count is not 8.")
		get_tree().quit()

	# Initialize the danger array with eight zeros
	_danger_array.resize(8)
	_danger_array.fill(0)

## Normalize the danger array to values between 0 and max_obstacle_danger.
func _normalize_danger_array():
	_danger_array = _danger_array.map(func(x: float): if x > 0: return 1.0 else: return 0)
	_danger_array = _danger_array.map(func(x: float): return x * max_obstacle_danger)

## Add 60% danger to nearby directions around the detected obstacles.
func _pad_danger_array():
	var d_size = _danger_array.size()
	var pad_decrement = 0.6

	var indexes_to_ignore = []
	indexes_to_ignore.resize(d_size)
	indexes_to_ignore.fill(false)

	for i in range(d_size):
		if indexes_to_ignore[i]:
			continue

		if _danger_array[i] > 0:
			var prev_index = (i - 1) % d_size
			var next_index = (i + 1) % d_size

			if _danger_array[prev_index] == 0:
				_danger_array[prev_index] = pad_decrement * _danger_array[i]
				indexes_to_ignore[prev_index] = true
			
			if _danger_array[next_index] == 0:
				_danger_array[next_index] = pad_decrement * _danger_array[i]
				indexes_to_ignore[next_index] = true

	if debug:
		print("ObstacleDetector> Padded danger array: ", Utils.format_array(_danger_array, "%.2f"))

func get_danger_array():
	for i in range(_rays.size()):
		var ray = _rays[i]

		if ray.is_colliding():
			var coll_point = ray.get_collision_point()
			var ray_global_pos = ray.global_position

			# Calculate the distance between the ray and the collision point
			_danger_array[i] = ray_global_pos.distance_to(coll_point)
		else:
			_danger_array[i] = 0
	
	_normalize_danger_array()
	_pad_danger_array()

	return _danger_array
