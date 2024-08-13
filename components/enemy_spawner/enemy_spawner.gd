extends Node2D

func _ready():
	var spawners = get_children()

	for s in spawners:
		var enemy_to_spawn = GlobalData.enemies_scenes.pick_random().instantiate()

		get_parent().call_deferred("add_child", enemy_to_spawn)

		await enemy_to_spawn.ready

		enemy_to_spawn.global_position = s.global_position
		s.queue_free()