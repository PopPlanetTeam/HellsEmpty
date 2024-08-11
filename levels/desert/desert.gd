extends Node2D

@export_group("Audio")
@export var level_song: AudioStream
@export var song_volume_db: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if level_song:
		GlobalAudioPlayer.play_stream(level_song, song_volume_db)
