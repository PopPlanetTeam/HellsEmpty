extends Node2D
class_name Coin

@onready var _audio = $AudioStreamPlayer2D

func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	
	print(parent)
	
	if parent is PlayerBase:
		visible = false

		_audio.play()
		await _audio.finished
		
		queue_free()
