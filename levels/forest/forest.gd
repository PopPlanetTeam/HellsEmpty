extends Node2D

@onready var player : PlayerBase = $PlayerNoWeapon
@onready var auto_save_timer : Timer = $Autosave

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalData.level_enemies_killed = 0
	GlobalData.total_time_survived = Time.get_ticks_msec() / 1000.
	GlobalData.total_level_coins_collected = PlayerInventory.coins_amount
	
	PlayerInventorySaverLoader.new().load_scene()
	if PlayerInventory.current_weapon != null:
		if GlobalData.player !=  null:
				var player_with_weapon : PlayerWithWeapon = GlobalData.player_with_weapon_scene.instantiate()
				player_with_weapon.transform = player.transform
				player_with_weapon.position = player.position
				player_with_weapon.global_position = player.global_position

				SwitchNodes.transfer_all_children_added_on_this_scene(player, player_with_weapon)
				self.add_child(player_with_weapon)
				player_with_weapon.SPEED = player.SPEED
				player.queue_free()
				
				player = player_with_weapon
				GlobalData.player = player
				player.weapon_slot.assign_weapon(PlayerInventory.current_weapon)
				
	player.player_died.connect(_game_over_screen)


func _game_over_screen():
	GlobalDataSaverLoader.new().save_scene()
	PlayerInventorySaverLoader.new().save_scene()
	get_tree().change_scene_to_file("res://levels/GameOver.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		PlayerInventorySaverLoader.new().save_scene()
		GlobalDataSave.new().save_scene()

func _on_autosave_timeout() -> void:
	GlobalDataSaverLoader.new().save_scene()
	PlayerInventorySaverLoader.new().save_scene()
	auto_save_timer.start()
