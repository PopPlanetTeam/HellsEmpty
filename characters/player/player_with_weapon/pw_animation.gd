extends AnimationPlayer

@export var vertical_threshold: int = 50
@export var player_sprites: Node2D

@onready var _weapon_slot: WeaponSlot = %WeaponSlot

var _origin: Marker2D
var _current_animation: String = ""

var _node_ready: bool = false

func _ready():
	if not player_sprites:
		printerr("PwAnimation> ERROR: No player_sprites assigned.")
		get_tree().quit()
		return
	
	await _weapon_slot.ready

	_origin = _weapon_slot.get_origin()
	_node_ready = true
	
func _process(_delta):
	if _node_ready:
		var aiming_angle = _get_aiming_direction().angle()

		_set_rotation_around_origin(aiming_angle)
	
func _get_aiming_direction() -> Vector2:
	return (player_sprites.get_global_mouse_position() - _origin.global_position)

func _get_mouse_direction() -> Vector2:
	return (player_sprites.get_global_mouse_position() - player_sprites.global_position)

func _flip_animation(_flip_h: bool):
	if _flip_h:
		_current_animation += "_flip"
	else:
		_current_animation = _current_animation.replace("_flip", "")

# Set the rotation of the WeaponSlot node around the origin Marker2D
func _set_rotation_around_origin(angle: float) -> void:
	# Mark origin position before any transformations
	var origin_start_pos = Vector2(_origin.global_position)

	# Rotate the WeaponSlot node
	_weapon_slot.rotation = angle

	# Flip the WeaponSlot node vertically if the angle is greater than 90 degrees
	if angle > deg_to_rad(90) or angle < deg_to_rad( - 90):
		_weapon_slot.scale.y *= - 1 if _weapon_slot.scale.y > 0 else 1
	else:
		_weapon_slot.scale.y *= - 1 if _weapon_slot.scale.y < 0 else 1
	
	# Compensate the flip and rotation by moving the WeaponSlot node
	_weapon_slot.global_position -= (_origin.global_position - origin_start_pos)

func animate(velocity: Vector2):
	player_sprites.z_index = 0

	var mouse_direction = _get_mouse_direction()

	if velocity.length() > 0:
		# The player is moving in the horizontal
		if velocity.x != 0:
			if (mouse_direction.x > 0 and velocity.x > 0) or (mouse_direction.x < 0 and velocity.x < 0):
				_current_animation = "run_front"
			else:
				_current_animation = "run_back"

			if mouse_direction.y < - vertical_threshold:
				_current_animation = "run_up"
			elif mouse_direction.y > vertical_threshold:
				_current_animation = "run_down"
			
			_flip_animation(velocity.x < 0)
		# The player is moving in the vertical
		elif velocity.y != 0:
			if velocity.y < 0:
				player_sprites.z_index = 1
				_current_animation = "run_back_up"
			else:
				player_sprites.z_index = 0
				_current_animation = "run_up_down"
			
			if mouse_direction.y > vertical_threshold and velocity.y < 0:
				player_sprites.z_index = 0
				_current_animation = "run_back_back"
			elif mouse_direction.y < - vertical_threshold and velocity.y > 0:
				_current_animation = "run_up_up"
	else:
		if mouse_direction.y < - vertical_threshold:
			_current_animation = "idle_up"
		elif mouse_direction.y > vertical_threshold:
			_current_animation = "idle_down"
		else:
			_current_animation = "idle_front"
		
		_flip_animation(mouse_direction.x < 0)

	self.current_animation = _current_animation

func damage_animation():
	_current_animation = "damage"
	self._flip_animation(_get_mouse_direction().x < 0)
	self.play(_current_animation)

func die_animation():
	_current_animation = "die"
	self.play(_current_animation)