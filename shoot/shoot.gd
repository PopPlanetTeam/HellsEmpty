extends Node2D

var speed = 500 
var direction
var viewport_size = get_viewport_rect().size
var x_out
var y_out
@onready var game = get_parent()
@onready var shoot = $shoot_audio
@onready var enemy = game.get_node("Enemy")

func _ready():
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - position).normalized()
	viewport_size = get_viewport_rect().size
	shoot.play()

func _process(delta):
	position += direction * speed * delta
	
	x_out = position.x < -1300 or position.x > 1800
	y_out = position.y < -700 or position.y > 1000
	
	if x_out or y_out:
		queue_free()

