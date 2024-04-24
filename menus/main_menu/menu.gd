extends Node2D

func _ready():
	%OpcoesMenu.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		var current_mode = DisplayServer.window_get_mode()

		if current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://levels/safe_house/safe_house.tscn")

func _on_opcoes_pressed():
	%OpcoesMenu.visible = true

func _on_sair_pressed():
	get_tree().quit()
