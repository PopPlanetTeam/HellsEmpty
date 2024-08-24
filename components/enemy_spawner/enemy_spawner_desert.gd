extends Node2D
class_name EnemySpawnerDesert

@export var disable: bool = false

func spawn_enemies() -> void:
	if disable:
		return
	
	var spawners = get_children()

	for s in spawners:
		var enemy_to_spawn = GlobalData.enemies_scenes.pick_random().instantiate()

		self.add_child(enemy_to_spawn)

		enemy_to_spawn.global_position = s.global_position
		s.queue_free()
	
	# Disable this node, so it doesn't spawn enemies again
	disable = true

# Saving the enemies. After spawning the enemies, this node will delete the Markers2D and will have all the enemies as children
func save(enemies_dict: Dictionary) -> void:
	var enemies_array: Array[EnemieSave] = []

	for e in get_children():
		e = e as EnemyBase
		if e == null:
			continue
		var enemy_save = EnemieSave.new()

		enemy_save.scene_path = e.scene_file_path
		enemy_save.global_position = e.global_position
		enemy_save.life = e.health_component.life

		enemies_array.append(enemy_save)

	enemies_dict["spawner_disable"] = disable
	enemies_dict["enemies"] = enemies_array

func load(enemies_dict: Dictionary) -> void:
	disable = enemies_dict["spawner_disable"]

	# Free the markers
	for m in get_children():
		m.queue_free()

	var enemies_array = enemies_dict["enemies"] as Array[EnemieSave]

	# Load the enemies
	for e in enemies_array:
		e = e as EnemieSave

		var enemy = load(e.scene_path).instantiate()
		
		self.add_child(enemy)

		enemy.global_position = e.global_position
		enemy.health_component.life = e.life
