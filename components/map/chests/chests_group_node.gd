extends Node2D

func save(chest_array: Array):
	var childs = get_children()

	for c in childs:
		c = c as Chest

		var chest_save = ChestSave.new()

		chest_save.node_name = c.name
		chest_save.is_open = c.is_open()

		chest_array.append(chest_save)

func load(chest_array: Array):
	for c in chest_array:
		var chest = self.get_node_or_null(c.node_name.validate_node_name()) as Chest

		if chest:
			if c.is_open:
				chest.open(false)
		else:
			printerr("No chest found for node: " + c.node_name + ". Proceeding to next chest.")
