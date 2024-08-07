extends Control

var is_paused: bool = false

func _input(_event) -> void:
	if Input.is_action_just_pressed('pause'):
		if is_paused:
			self.hide()
			Engine.time_scale = 1
		else:
			self.show()
			Engine.time_scale = 0
		is_paused = !is_paused
