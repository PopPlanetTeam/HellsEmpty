extends State

signal next_to_player

@export var debug: bool = false

var _enemy: EnemyBase
var _player: PlayerBase
var _chase_distance: float

var _current_animation: String = "walk"
var _current_direction: Vector2
var _directions = [Vector2.RIGHT, Vector2.LEFT]
var _timer: Timer

## This function is automatically called when the state is entered.
func Enter():
	_enemy = state_machine.get_parent()
	_chase_distance = _enemy.chase_distance

	_timer = Timer.new()
	_timer.wait_time = randf_range(3.0, 7.0)
	_timer.one_shot = true
	_timer.autostart = true
	_timer.timeout.connect(_on_timer_timeout)
	_enemy.call_deferred("add_child", _timer)

	# Set random direction to start walking
	_current_direction = _directions[randi() % 2]
	
	# Create debug line and label
	if debug:
		var line = Line2D.new()
		var distance_label = Label.new()

		line.name = "DebugLine"
		line.default_color = Color.RED
		line.width = 2

		distance_label.name = "DistanceLabel"
		distance_label.position = Vector2(50, 0)
		distance_label.add_theme_color_override("font_color", Color.RED)
		distance_label.add_theme_font_size_override("font_size", 12)
		
		_enemy.call_deferred("add_child", line)
		_enemy.call_deferred("add_child", distance_label)

## This function is automatically called when the state is exited.
func Exit():
	# Remove debug line and label on exit
	if debug:
		_enemy.get_node("DebugLine").queue_free()
		_enemy.get_node("DistanceLabel").queue_free()

func _physics_process(_delta):
	_enemy.animation_sprites.play(_current_animation)

	_enemy.velocity = _current_direction * (_enemy.speed / 2)
	_enemy.move_and_slide()

	if _enemy.is_on_wall():
		_current_direction *= -1
		_enemy.animation_sprites.flip_h = _current_direction.x < 0

	_player = GlobalData.player
	if _player:
		var distance: float = _enemy.global_position.distance_to(_player.global_position)

		if distance <= _chase_distance:

			# Create Physics2DShapeQueryParameters
			var query = PhysicsRayQueryParameters2D.create(_enemy.global_position, _player.global_position, _enemy.collision_mask)

			# Check if there is no obstacle between the player and the enemy
			var result = _enemy.get_world_2d().direct_space_state.intersect_ray(query)

			if not result:
				next_to_player.emit()
		
		# Update debug line and label
		if debug and _enemy.has_node("DebugLine"):
			var line: Line2D = _enemy.get_node("DebugLine")
			var distance_label: Label = _enemy.get_node("DistanceLabel")

			line.set_points([line.to_local(_enemy.global_position), line.to_local(_player.global_position)])
			distance_label.text = "Player dist: " + str(distance as int)

func _on_timer_timeout():
	var decision = randi() % 2

	print("Decision: ", decision)

	if decision == 0:
		_current_animation = "walk"
		_current_direction = _directions[randi() % _directions.size()]
		_enemy.animation_sprites.flip_h = _current_direction.x < 0
	else:
		_current_animation = "idle"
		_current_direction = Vector2.ZERO
	
	_timer.wait_time = randf_range(3.0, 7.0)
	_timer.start()
