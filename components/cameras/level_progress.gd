extends Label

@onready var root_node = get_tree().root

func _process(delta: float) -> void:
	if GlobalData.level_enemies_killed == GlobalData.current_level_goal:
		self.add_theme_color_override("font_color", Color.DARK_RED)
	self.text = str(GlobalData.level_enemies_killed) 

func _setup_event_handlers():
	_on_enemy_died_handler()
	get_tree().get_nodes_in_group(GlobalData.ENEMY_GROUP) \
		.map(func (enemy): enemy.connect("died", _on_enemy_died_handler))

func _on_enemy_died_handler():
	self.text = str(GlobalData.level_enemies_killed) 
	#+ "/" + str(kills_to_win)
