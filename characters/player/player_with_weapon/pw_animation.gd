extends AnimationPlayer

@export var vertical_threshold: int = 50
@export var player_sprites: Node2D
@export var player_prites_overlay: Node2D
@export var animation_container: Node2D

@onready var _weapon_slot: Node2D = %WeaponSlot

var _origin: Marker2D
var _current_animation: String = ""

func _ready():
	if not animation_container or not player_sprites or not player_prites_overlay:
		printerr("PwAnimation> ERROR: one of the required nodes is missing.")
		get_tree().quit()
	
	await _weapon_slot.ready
	_origin = _weapon_slot.get_origin()
	
func _process(_delta):
	var aiming_angle = _get_aiming_direction().angle()

	_set_rotation_around_origin(aiming_angle)
	
func _get_aiming_direction() -> Vector2:
	return (_weapon_slot.get_global_mouse_position() - _weapon_slot.weapon.global_position)

func _get_mouse_direction() -> Vector2:
	return (player_sprites.get_global_mouse_position() - player_sprites.global_position)

func _flip_animation(_flip_h: bool):
	if _flip_h:
		_current_animation += "_flip"
	else:
		_current_animation = _current_animation.replace("_flip", "")

# Set the rotation of the WeaponSlot node around the origin Marker2D
func _set_rotation_around_origin(angle: float) -> void:
	var original_position = Vector2(_origin.global_position)

	_weapon_slot.rotation = angle
	_weapon_slot.global_position -= (_origin.global_position - original_position)

	if angle > deg_to_rad(90) or angle < deg_to_rad( - 90):
		_weapon_slot.weapon.scale.y *= - 1 if _weapon_slot.weapon.scale.y > 0 else 1
	else:
		_weapon_slot.weapon.scale.y *= - 1 if _weapon_slot.weapon.scale.y < 0 else 1

func animate(velocity: Vector2):
	player_sprites.visible = true
	player_prites_overlay.visible = false

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
		elif velocity.y != 0:
			if velocity.y < 0:
				player_prites_overlay.visible = true
				player_sprites.visible = false
				_current_animation = "run_back_up"
			else:
				player_prites_overlay.visible = false
				player_sprites.visible = true
				_current_animation = "run_up_down"
			
			if mouse_direction.y < - vertical_threshold and velocity.y < 0:
				_current_animation = "run_back_back"
			elif mouse_direction.y > vertical_threshold and velocity.y > 0:
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
