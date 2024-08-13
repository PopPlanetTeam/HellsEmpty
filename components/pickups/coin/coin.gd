extends Pickup

@onready var _audio = $AudioStreamPlayer2D
@onready var _area_2d = $Area2D

func _on_area_2d_area_entered(_area):
	visible = false

	PlayerInventory.coins_amount += 1

	_audio.play()
	await _audio.finished
	
	queue_free()

func set_enabled(enabled: bool) -> void:
	_area_2d.monitoring = enabled
