extends Label

@onready var root_node = get_tree().root
var kills_to_win = 35

func _setup_event_handlers():
	_on_enemy_died_handler()
	get_tree().get_nodes_in_group(GlobalData.ENEMY_GROUP) \
		.map(func (enemy): enemy.connect("died", _on_enemy_died_handler))

func _on_enemy_died_handler():
	self.text = str(GlobalData.level_enemies_killed) + "/" + str(kills_to_win)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
