extends RigidBody2D

var speed : float = 0.0
var direction : Vector2 = Vector2.ZERO
var damage : float = 0.0

@onready var audio:AudioStreamPlayer = $shoot_audio

func _ready():
	if !direction:
		var mouse_position = get_global_mouse_position()
		direction = (mouse_position - position).normalized()
	audio.play()

func _on_hitbox_area_entered(area):
	if area is HitBox:
		var hitbox:HitBox = area
		hitbox.take_damage(damage)

func _process(delta):
	position += speed * direction * delta
