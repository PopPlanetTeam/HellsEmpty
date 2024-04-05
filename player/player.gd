extends CharacterBody2D

@onready var player_sprite: Sprite2D = get_node("Sprite")
@onready var scene = get_parent()
@onready var shoot_timer = $Shoot_timer
@onready var heal_timer = $Heal_timer

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var can_shoot = true
var can_drop_bomb = false
var life : float = 100.0
const angle_between_shoots = 25.0
const angle_between_shoots_radians = deg_to_rad(angle_between_shoots)
var time_between_shots = 1.0/15.0
var heal_timer_started = false

var commands_table = {}

func _ready() -> void:
	commands_table["shoot"] = shoot_handler
	commands_table["shoot_radial"] = shoot_radial_handler
	commands_table["triple_shoot_radial"] = triple_shoot_radial_handler
	commands_table["mega_shoot"] = mega_shoot_handler

func handle_shoot_event() -> void:
	for action in commands_table:
		if can_shoot and Input.is_action_pressed(action):
			commands_table[action].call()

func shoot_radial_handler() -> void:
	can_shoot = false
	shoot_timer.start(time_between_shots * 1.4)
	var mouse_position = get_global_mouse_position()
	var mouse_vector = (mouse_position - position).normalized()
	
	const shots = 5
	for i in range(0,shots):
		var shoot = load("res://shoot/shoot.tscn").instantiate()
		shoot.damage /= shots
		shoot.position = position
		shoot.speed *= 1.3
		shoot.direction = Vector2(mouse_vector).rotated((i as float / shots as float) * 2.0 * PI)
		scene.add_child(shoot)

func shoot_handler() -> void:
	can_shoot = false
	shoot_timer.start(time_between_shots)
	var shoot = load("res://shoot/shoot.tscn").instantiate()
	shoot.position = position
	scene.add_child(shoot)
	
func mega_shoot_handler() -> void:
	can_shoot = false
	shoot_timer.start(time_between_shots * 1.4)
	var mouse_position = get_global_mouse_position()
	var mouse_vector = (mouse_position - position).normalized()
	
	var shoot = load("res://shoot/shoot.tscn").instantiate()
	shoot.damage *= 1.65
	shoot.transform = shoot.transform.scaled(Vector2(1.5, 1.5))
	shoot.speed /= 2.0
	shoot.position = position
	scene.add_child(shoot)

func triple_shoot_radial_handler() -> void:
	can_shoot = false
	shoot_timer.start(time_between_shots)
	var mouse_position = get_global_mouse_position()
	var mouse_vector = (mouse_position - position).normalized()
	
	var shoot = load("res://shoot/shoot.tscn").instantiate()
	shoot.damage /= 3.0 
	shoot.position = position
	shoot.direction = Vector2(mouse_vector).rotated(-angle_between_shoots_radians)
	scene.add_child(shoot)
	
	shoot = load("res://shoot/shoot.tscn").instantiate()
	shoot.damage /= 3.0 
	shoot.position = position
	shoot.direction = Vector2(mouse_vector).rotated(0.0)
	scene.add_child(shoot)
	
	shoot = load("res://shoot/shoot.tscn").instantiate()
	shoot.damage /= 3.0 
	shoot.position = position
	shoot.direction = Vector2(mouse_vector).rotated(angle_between_shoots_radians)
	scene.add_child(shoot)
	
func _process(delta):
	$ProgressBar.value = life

func _physics_process(delta):
	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	
	if x_direction or y_direction:
		velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))
		
	handle_shoot_event()
	
	if can_drop_bomb and Input.is_action_pressed("drop_bomb"):
		pass

	if velocity.length_squared() == 0.0 and !heal_timer_started:
		heal_timer_started = true
		heal_timer.start(2.5)
	elif velocity.length_squared() != 0.0 and heal_timer_started:
		heal_timer_started = false
		heal_timer.stop()
		
	player_sprite.animate(velocity)
	move_and_slide()

func _on_shoot_timer_timeout():
	can_shoot = true

func _on_heal_timer_timeout():
	self.life = clampf(self.life + 5.0, 0.0, 100.0)
	heal_timer_started = false
	
func _on_damage_area_body_entered(body):
	if body.is_in_group("inflict_damage"):
		self.life -= (body.damage * body.life) / 100.0
		body.queue_free()
		if self.life <= 25.0:
			time_between_shots /= 1.5 
		if self.life <= 0.0:
			var game_over_scene:GameOver = load("res://game_over/game_over.tscn").instantiate()
			game_over_scene.almas_coletadas = scene.killed_enemies
			get_tree().get_root().add_child(game_over_scene)
			get_tree().get_root().remove_child(scene)
			queue_free()
