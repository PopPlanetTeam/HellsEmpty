extends SceneBase

@export_group("Audio")
@export var level_song: AudioStream
@export var song_volume_db: float = 0.0

@onready var enemy_spawner: EnemySpawner = $EnemySpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

	if level_song:
		GlobalAudioPlayer.play_stream(level_song, song_volume_db)

func _new_scene():
	# Spawning enemies
	enemy_spawner.spawn_enemies()
