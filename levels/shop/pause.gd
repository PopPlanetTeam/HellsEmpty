extends Node2D

@onready var paused_label = $Paused

func _ready():
	paused_label.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause = get_tree().paused
		get_tree().paused = !pause
		paused_label.visible = !pause
		
