extends CharacterBody2D
class_name PlayerBase

@export var SPEED = 190.0
@export var hitbox: HitBox
@export var player_animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

@export_group("Layers and Masks")
@export_flags_2d_physics var provides_collision = 0
@export_flags_2d_physics var scan_collision = 0
@export_flags_2d_physics var takes_damage = 0

var _knockback: Vector2 = Vector2.ZERO
var _movement_enabled: bool = true

func _ready():
	if not hitbox:
		printerr("PlayerBase> ERROR: No HitBox assigned.")
		get_tree().quit()
		return

	if not (player_animated_sprite or animation_player):
		printerr("PlayerBase> ERROR: No AnimatedSprite2D or AnimationPlayer assigned.")
		get_tree().quit()
		return
	
	if player_animated_sprite and player_animated_sprite.get_script() == null:
		printerr("PlayerBase> ERROR: AnimatedSprite2D has no script assigned.")
		get_tree().quit()
		return
	
	if animation_player and animation_player.get_script() == null:
		printerr("PlayerBase> ERROR: AnimationPlayer has no script assigned.")
		get_tree().quit()
		return

	self.collision_layer = provides_collision
	self.collision_mask = scan_collision
	hitbox.collision_layer = takes_damage
	hitbox.collision_mask = takes_damage
   
	# Add itself to the global player variable
	GlobalData.player = self

func _physics_process(_delta):
	if not _knockback.is_equal_approx(Vector2.ZERO):
		# We gonna redirect the physics process to the _knockback process
		_knockback_process()
		return

	if not _movement_enabled:
		return

	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	
	if x_direction or y_direction:
		velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))
	
	if player_animated_sprite:
		player_animated_sprite.animate(velocity)
	else:
		animation_player.animate(velocity)
	
	move_and_slide()

func _knockback_process():
	velocity += _knockback

	move_and_slide()
	_knockback = _knockback.lerp(Vector2.ZERO, 0.5)

func _on_died():
	self.queue_free()

func set_movement_enabled(enabled: bool):
	_movement_enabled = enabled
