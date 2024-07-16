extends CharacterBody2D
class_name PlayerBase

@export var player_animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer
@export var SPEED = 300.0

func _ready():
	if not (player_animated_sprite or animation_player):
		printerr("PlayerBase> ERROR: No AnimatedSprite2D or AnimationPlayer assigned.")
		get_tree().quit()
	
	if player_animated_sprite and player_animated_sprite.get_script() == null:
		printerr("PlayerBase> ERROR: AnimatedSprite2D has no script assigned.")
		get_tree().quit()
	
	if animation_player and animation_player.get_script() == null:
		printerr("PlayerBase> ERROR: AnimationPlayer has no script assigned.")
		get_tree().quit()

func _physics_process(_delta):
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
