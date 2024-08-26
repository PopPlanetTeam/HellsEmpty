extends Label

func _process(_delta: float) -> void:
	self.text = str(GlobalData.current_level_goal)
