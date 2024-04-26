extends Control

enum LANGUAGES {PORTUGUES, ENGLISH}

func _ready():
	%LanguageLabel.text = tr("IDIOMA")
	%FullscreenLabel.text = tr("FULLSCREEN")
	%FullscreenButton.text = tr("HABILITADO")

func _on_back_pressed():
	self.visible = false

func _on_language_selector_item_selected(index):
	match index:
		LANGUAGES.PORTUGUES:
			TranslationServer.set_locale("br")
			get_tree().call_group("main_menu", "change_options_language", "br")
		LANGUAGES.ENGLISH:
			TranslationServer.set_locale("us")
			get_tree().call_group("main_menu", "change_options_language", "us")

func _on_fullscreen_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass

func _process(_delta):
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%FullscreenButton.set_pressed_no_signal(true)
	else:
		%FullscreenButton.set_pressed_no_signal(false)
