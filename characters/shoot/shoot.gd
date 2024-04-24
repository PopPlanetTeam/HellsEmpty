extends CharacterBody2D
class_name Shot

@export var damage:float = 51
var speed = 500 
var direction = null
@onready var game = get_parent()
@onready var shoot = $shoot_audio

func _ready():
	if !direction:
		var mouse_position = get_global_mouse_position()
		direction = (mouse_position - position).normalized()
	shoot.play()

func _process(delta):
	position += direction * speed * delta
