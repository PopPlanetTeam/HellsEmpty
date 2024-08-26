class_name SwitchNodes

static func transfer_all_children_added_on_this_scene(from_node, to_node):
	from_node.get_children(false) \
		.filter(func(child): return child.owner != from_node) \
		.map(func(child): transfer_child(from_node, to_node, child))

static func transfer_child(from_node, to_node, child):
	from_node.remove_child(child)
	to_node.add_child(child)
