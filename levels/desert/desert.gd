extends SceneBase

@export_group("Audio")
@export var level_song: AudioStream
@export var song_volume_db: float = 0.0

@onready var saver_loader: SceneSaverLoader = $SceneSaverLoader

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

	if level_song:
		GlobalAudioPlayer.play_stream(level_song, song_volume_db)
	
	if SceneManager.transition_happened():
		saver_loader.load_scene()
