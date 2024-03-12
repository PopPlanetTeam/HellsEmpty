extends CharacterBody2D

var speed = 500 
var direction
var viewport_size = get_viewport_rect().size
@onready var game = get_parent()
@onready var shoot = $shoot_audio

func _ready():
	var mouse_position = get_global_mouse_position()
	direction = (mouse_position - position).normalized()
	viewport_size = get_viewport_rect().size
	shoot.play()

func _process(delta):
	position += direction * speed * delta
