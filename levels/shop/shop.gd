extends Node2D

@onready var player : PlayerBase = $PlayerNoWeapon
@onready var weapons = $Weapons
@onready var desert_map_tilemap = $DesertMap

# Called when the node enters the scene tree for the first time.
func _ready():
	# Disable desert collisions 
	desert_map_tilemap.tile_set.set_physics_layer_collision_layer(0, 0)
	
	PlayerInventorySaverLoader.new().load_scene()
	if PlayerInventory.current_weapon != null:
		set_weapon_for_player(PlayerInventory.current_weapon)

	# Listen for all weapon selected signals
	weapons.get_children() \
		.filter(func(item): return item.has_signal("weapon_selected")) \
		.map(func(weapon_container:WeaponContainer): weapon_container.connect("weapon_selected", set_weapon_for_player))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_entered_weapon_selection(area:Area2D):
	if area.get_parent() is PlayerBase and player is PlayerWithWeapon:
		var current_weapon = player.weapon_slot.weapon
		if current_weapon:
			current_weapon.set_process_input(false)

func _on_player_exited_weapon_selection(area:Area2D):
	if area.get_parent() is PlayerBase and player is PlayerWithWeapon:
		var current_weapon = player.weapon_slot.weapon
		if current_weapon:
			current_weapon.set_process_input(true)
		
func change_player_no_weapon_to_player_with_weapon():
	var player_with_weapon : PlayerWithWeapon = GlobalData.player_with_weapon_scene.instantiate()
	player_with_weapon.transform = player.transform
	player_with_weapon.position = player.position
	player_with_weapon.global_position = player.global_position
	player_with_weapon.SPEED = player.SPEED
	
	SwitchNodes.transfer_all_children_added_on_this_scene(player, player_with_weapon)
	self.add_child(player_with_weapon)
	player.visible = false
	player.queue_free()
	
	player = player_with_weapon
	GlobalData.player = player
	
	# Listen from all weapon selection area entered
	get_tree().get_nodes_in_group(GlobalData.WEAPON_CONTAINER_SELECTION_AREA_GROUP) \
		.filter(func (item): return item.has_signal("area_entered")) \
		.map(func(item:Area2D): item.connect("area_entered", _on_player_entered_weapon_selection))
		
	# Listen from all weapon selection area exited
	get_tree().get_nodes_in_group(GlobalData.WEAPON_CONTAINER_SELECTION_AREA_GROUP) \
		.filter(func(item) : return item.has_signal("area_exited")) \
		.map(func(item:Area2D): item.connect("area_exited", _on_player_exited_weapon_selection))

func set_weapon_for_player(weapon:WeaponBase):
	if player is PlayerNoWeapon:
		change_player_no_weapon_to_player_with_weapon()
	elif player is PlayerWithWeapon:
		if player.weapon_slot.weapon.name == weapon.name:
			return
		player.weapon_slot.weapon.queue_free()
	
	player.weapon_slot.assign_weapon(weapon.duplicate())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		PlayerInventorySaverLoader.new().save_scene()

func _on_go_to_desert_area_entered(area: Area2D) -> void:
	if area.get_parent() is PlayerBase:
		PlayerInventorySaverLoader.new().save_scene()
		GlobalData.total_time_survived = Time.get_ticks_msec() / 1000.
		GlobalData.total_level_coins_collected = PlayerInventory.coins_amount
		
		# Reset level kills
		GlobalData.level_enemies_killed = 0
		
		desert_map_tilemap.tile_set.set_physics_layer_collision_layer(0, 1)
		SceneManager.last_scene = ""
		get_tree().change_scene_to_file("res://levels/desert/desert.tscn")

func _on_go_to_forest_area_entered(area: Area2D) -> void:
	if area.get_parent() is PlayerBase:
		PlayerInventorySaverLoader.new().save_scene()
		
		# Reset level kills
		GlobalData.level_enemies_killed = 0
		
		get_tree().change_scene_to_file("res://levels/forest/Forest.tscn")
