extends Node2D

func _ready():
	# Idioma padrão será Português dos guri
	TranslationServer.set_locale("br")
	
	%OpcoesMenu.visible = false

func _process(_delta):
	pass

func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://levels/safe_house/safe_house.tscn")

func _on_opcoes_pressed():
	%OpcoesMenu.visible = true

func _on_sair_pressed():
	get_tree().quit()

func change_options_language(language: String):
	var start: CompressedTexture2D
	var start_click: CompressedTexture2D
	var start_hover: CompressedTexture2D
	var options: CompressedTexture2D
	var options_click: CompressedTexture2D
	var options_hover: CompressedTexture2D
	var exit: CompressedTexture2D
	var exit_click: CompressedTexture2D
	var exit_hover: CompressedTexture2D

	match language:
		"br":
			start = preload("res://menus/main_menu/imgs/br/iniciar.png")
			start_click = preload("res://menus/main_menu/imgs/br/iniciar_click.png")
			start_hover = preload("res://menus/main_menu/imgs/br/iniciar_hover.png")
	
			options = preload("res://menus/main_menu/imgs/br/opcoes.png")
			options_click = preload("res://menus/main_menu/imgs/br/opcoes_click.png")
			options_hover = preload("res://menus/main_menu/imgs/br/opcoes_hover.png")

			exit = preload("res://menus/main_menu/imgs/br/sair.png")
			exit_click = preload("res://menus/main_menu/imgs/br/sair_click.png")
			exit_hover = preload("res://menus/main_menu/imgs/br/sair_hover.png")
		
		"us":
			start = preload("res://menus/main_menu/imgs/us/start.png")
			start_click = preload("res://menus/main_menu/imgs/us/start_click.png")
			start_hover = preload("res://menus/main_menu/imgs/us/start_hover.png")

			options = preload("res://menus/main_menu/imgs/us/options.png")
			options_click = preload("res://menus/main_menu/imgs/us/options_click.png")
			options_hover = preload("res://menus/main_menu/imgs/us/options_hover.png")

			exit = preload("res://menus/main_menu/imgs/us/exit.png")
			exit_click = preload("res://menus/main_menu/imgs/us/exit_click.png")
			exit_hover = preload("res://menus/main_menu/imgs/us/exit_hover.png")
		
	%IniciarButton.texture_normal = start
	%IniciarButton.texture_pressed = start_click
	%IniciarButton.texture_hover = start_hover

	%OpcoesButton.texture_normal = options
	%OpcoesButton.texture_pressed = options_click
	%OpcoesButton.texture_hover = options_hover

	%SairButton.texture_normal = exit
	%SairButton.texture_pressed = exit_click
	%SairButton.texture_hover = exit_hover
