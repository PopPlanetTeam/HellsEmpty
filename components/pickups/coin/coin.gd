extends Node2D

@onready var _audio = $AudioStreamPlayer2D

func _on_area_2d_area_entered(_area):
	visible = false

	PlayerInventory.coins_amount += 1

	_audio.play()
	await _audio.finished
	
	queue_free()
