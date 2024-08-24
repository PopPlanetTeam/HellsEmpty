extends SceneBase

@export var kills_to_win: int = 35
@export_group("Audio")
@export var level_song: AudioStream
@export var song_volume_db: float = 0.0

@onready var enemy_spawner: EnemySpawnerDesert = $EnemySpawner
@onready var next_level_portal: ScenePortal = $SafeHousePortal
@onready var exit_passage: TileMap = $ExitPassage
@onready var player = $PlayerNoWeapon
@onready var pause = $Pause
@onready var auto_save_timer : Timer = $Autosave

func transfer_all_children_added_on_this_scene(from_node, to_node):
	from_node.get_children(false) \
		.filter(func(child): return child.owner != from_node) \
		.map(func(child): transfer_child(from_node, to_node, child))
		
func transfer_child(from_node, to_node, child):
	from_node.remove_child(child)
	to_node.add_child(child)

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

	next_level_portal.set_enabled(false)
	_set_exit_passage_enabled(false)
	
	%LevelProgress._setup_event_handlers()
	%LevelProgress.kills_to_win = kills_to_win
	GlobalData.level_enemies_killed = 0
	
	PlayerInventorySaverLoader.new().load_scene()
	if PlayerInventory.current_weapon != null:
		if GlobalData.player !=  null:
				var player_with_weapon : PlayerWithWeapon = GlobalData.player_with_weapon_scene.instantiate()
				player_with_weapon.transform = player.transform
				player_with_weapon.position = player.position
				player_with_weapon.global_position = player.global_position

				transfer_all_children_added_on_this_scene(player, player_with_weapon)
				self.add_child(player_with_weapon)
				player.queue_free()
				
				player = player_with_weapon
				GlobalData.player = player
				player.weapon_slot.assign_weapon(PlayerInventory.current_weapon)
	
	if level_song:
		GlobalAudioPlayer.play_stream(level_song, song_volume_db)

func _new_scene():
	GlobalData.level_enemies_killed = 0
	
	# Spawning enemies
	enemy_spawner.spawn_enemies()

func _process(_delta):
	if GlobalData.level_enemies_killed == kills_to_win:
		# Enable portal
		next_level_portal.set_enabled(true)
		_set_exit_passage_enabled(true)
		
		# Nothing else to do, disable process
		set_process(false)

func _set_exit_passage_enabled(enabled: bool):
	exit_passage.visible = enabled
	
	exit_passage.set_layer_enabled(0, enabled)
	exit_passage.set_layer_enabled(1, enabled)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		PlayerInventorySaverLoader.new().save_scene()

func _on_autosave_timeout() -> void:
	PlayerInventorySaverLoader.new().save_scene()
	GlobalDataSaverLoader.new().save_scene()
	auto_save_timer.start()
