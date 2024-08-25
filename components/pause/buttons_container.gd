extends VBoxContainer

@onready var back_to_menu = $BackToMenuButton
@onready var back_to_shop = $BackToShopButton
@onready var save = $SaveButton
@onready var quit = $QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_to_menu.text = tr("BACK_TO_MAIN_MENU").to_upper()
	back_to_shop.text = tr("BACK_TO_SHOP").to_upper()
	save.text = tr("SAVE").to_upper()
	quit.text = tr("QUIT").to_upper()

func _on_back_to_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/main_menu/menu.tscn")

func _on_back_to_shop_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/shop/shop.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_save_button_pressed() -> void:
	PlayerInventorySaverLoader.new().save_scene()
	GlobalDataSaverLoader.new().save_scene()
