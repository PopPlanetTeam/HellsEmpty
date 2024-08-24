extends SceneBase

@export var kills_to_win: int = 35
@export_group("Audio")
@export var level_song: AudioStream
@export var song_volume_db: float = 0.0

@onready var enemy_spawner: EnemySpawner = $EnemySpawner
@onready var next_level_portal: ScenePortal = $SafeHousePortal
@onready var exit_passage: TileMap = $ExitPassage

@onready var player = $PlayerNoWeapon

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

	next_level_portal.set_enabled(false)
	_set_exit_passage_enabled(false)

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
