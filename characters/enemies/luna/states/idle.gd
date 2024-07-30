extends State

signal next_to_player

@export var debug: bool = false

var _enemy: EnemyBase
var _player: PlayerBase
var _distance_threshold

## This function is automatically called when the state is entered.
func Enter():
	_enemy = state_machine.get_parent()
	_distance_threshold = _enemy.distance_threshold
	
	# Create debug line and label
	if debug:
		var line = Line2D.new()
		var distance_label = Label.new()

		line.name = "DebugLine"
		line.default_color = Color.RED

		distance_label.name = "DistanceLabel"
		distance_label.position = Vector2(100, 0)
		distance_label.add_theme_color_override("font_color", Color.RED)
		
		_enemy.call_deferred("add_child", line)
		_enemy.call_deferred("add_child", distance_label)

## This function is automatically called when the state is exited.
func Exit():
	# Remove debug line and label on exit
	if debug:
		_enemy.get_node("DebugLine").queue_free()
		_enemy.get_node("DistanceLabel").queue_free()

func _process(_delta):
	_player = GlobalData.player
	_enemy.animation_sprites.play("idle")

	if _player:
		var distance: float = _enemy.global_position.distance_to(_player.global_position)

		if distance < _distance_threshold:
			next_to_player.emit()
		
		# Update debug line and label
		if debug:
			var line: Line2D = _enemy.get_node("DebugLine")
			var distance_label: Label = _enemy.get_node("DistanceLabel")

			line.set_points([line.to_local(_enemy.global_position), line.to_local(_player.global_position)])
			distance_label.text = "Player dist: " + str(distance as int)
