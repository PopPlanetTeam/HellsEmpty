extends CharacterBody2D

@onready var player_sprite: Sprite2D = get_node("Sprite")
@onready var scene = get_parent()
@onready var shoot_timer = $Shoot_timer

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var can_shoot = true
var life : float = 100.0

func _process(delta):
	$ProgressBar.value = life

func _physics_process(delta):
	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	
	if x_direction or y_direction:
		velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))
		
	if can_shoot and Input.is_action_pressed("shoot"):
		can_shoot = false
		shoot_timer.start(shoot_timer.wait_time)
		var shoot = load("res://shoot/shoot.tscn").instantiate()
		shoot.position = position
		scene.add_child(shoot)

	player_sprite.animate(velocity)
	move_and_slide()

func _on_shoot_timer_timeout():
	can_shoot = true


func _on_damage_area_body_entered(body):
	if body.is_in_group("inflict_damage"):
		self.life -= body.damage
		body.queue_free()
		if self.life <= 25.0:
			$Shoot_timer.wait_time /= 1.5 
		if self.life <= 0.0:
			get_tree().change_scene_to_file("res://game_over/game_over.tscn")
			print("Perdeu")
	
