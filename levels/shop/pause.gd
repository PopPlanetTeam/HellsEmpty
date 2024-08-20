extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause = get_tree().paused
		get_tree().paused = !pause
