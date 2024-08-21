extends Pickup

@onready var _audio = $AudioStreamPlayer2D
@onready var _area_2d = $Area2D
@onready var _sprite = $Sprite2D

var heal_amount: float

func _ready():
	heal_amount = randf_range(10.0, 50.0)
	
	var scale_offset = 0.02 * (heal_amount - 10.0)
	_sprite.scale += Vector2(scale_offset, scale_offset)

func _on_area_2d_area_entered(_area):
	visible = false

	if GlobalData.player:
		GlobalData.player.health.regenerate(heal_amount)

	_audio.play()
	await _audio.finished
	
	queue_free()

func set_enabled(enabled: bool) -> void:
	_area_2d.monitoring = enabled

func can_rotate() -> bool:
	return false
