extends Node2D
class_name PickupsSpawner

# Curve limits
const min_height: float = 10.0
const max_height: float = 50.0
const min_width: float = 20.0
const max_width: float = 50.0
const min_end_offset: float = -1.0
const max_end_offset: float = 16.0

# Speed limits
const min_speed: float = 2.0
const max_speed: float = 4.0

@export var content: PackedScene

@onready var _path: Path2D = $Path2D
@onready var _path_follow: PathFollow2D = %PathFollow2D

var _curve_height: float : 
	set(value):
		# Must invert y values
		_curve_height = -value

		var old_value = _path.curve.get_point_position(1) # Midpoint
		var new_value = Vector2(old_value.x, _curve_height) # New midpoint
		
		_path.curve.set_point_position(1, new_value)

var _curve_width: float :
	set(value):
		_curve_width = value

		var old_value_1 = _path.curve.get_point_position(1) # Midpoint
		var old_value_2 = _path.curve.get_point_position(2) # End

		var nv_1 = Vector2(value / 2.0, old_value_1.y) # New midpoint
		var nv_2 = Vector2(value, old_value_2.y) # New end

		_path.curve.set_point_position(1, nv_1) # Setting new midpoint
		_path.curve.set_point_in(1, Vector2(-(nv_1.x / 2.0), 0))
		_path.curve.set_point_out(1, Vector2(nv_1.x / 2.0, 0))

		_path.curve.set_point_position(2, nv_2)

var _curve_flip_h: bool :
	set(value):
		_curve_flip_h = value

		if value:
			for i in range(_path.curve.point_count):
				var point = _path.curve.get_point_position(i)
				_path.curve.set_point_position(i, Vector2(-point.x, point.y))
				_path.curve.set_point_in(i, Vector2(-_path.curve.get_point_in(i).x, _path.curve.get_point_in(i).y))
				_path.curve.set_point_out(i, Vector2(-_path.curve.get_point_out(i).x, _path.curve.get_point_out(i).y))

var _curve_end_offset: float :
	set(value):
		_curve_end_offset = value

		var last_point = _path.curve.get_point_position(2) # Get last point
		_path.curve.set_point_position(2, Vector2(last_point.x, _curve_end_offset))

var _move_speed: float
var _content_node: Pickup
var _can_move: bool = false

func _ready():
	# Set curve limits
	_curve_height = randf_range(min_height, max_height)
	_curve_width = randf_range(min_width, max_width)
	_curve_flip_h = randi() % 2 == 0
	_curve_end_offset = randf_range(min_end_offset, max_end_offset)

	print("Height: " + str(_curve_height) + " Width: " + str(_curve_width) + " End offset: " + str(_curve_end_offset))

	_move_speed = randf_range(min_speed, max_speed)

	# Create content node
	_content_node = content.instantiate()
	_path_follow.call_deferred("add_child", _content_node)

	await _content_node.ready
	
	_content_node.set_enabled(false)
	_content_node.global_position = self.global_position

	self.z_index = 1

	_can_move = true

var _t: float = 0.0
func _physics_process(delta):
	if _can_move:
		_t += delta * _move_speed
		_path_follow.progress_ratio = _t

		if _t >= 1.0:
			_end_movement()

func _end_movement():
	_can_move = false

	_content_node.reparent(get_parent())
	_content_node.z_index = 0
	_content_node.set_enabled(true)

	queue_free()
