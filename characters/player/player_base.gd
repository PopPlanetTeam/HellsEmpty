extends CharacterBody2D
class_name PlayerBase

@export var player_sprite: Sprite2D
@export var SPEED = 150.0

func _ready():
	# Add itself to the global player variable
	GlobalData.player = self

func _physics_process(_delta):
	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	
	if x_direction or y_direction:
		velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))

	player_sprite.animate(velocity)
	move_and_slide()
