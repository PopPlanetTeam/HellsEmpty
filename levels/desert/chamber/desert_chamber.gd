extends SceneBase

@onready var camera : Camera2D = $Camera2D
@onready var enemy_spawn : EnemySpawnerDesert = $EnemySpawn
@onready var auto_save_timer : Timer = $Autosave

func _ready():
	super._ready()
	enemy_spawn.spawn_enemies()
	
	SceneManager.player_transition.player_died.connect(_game_over_scene)
	
func _game_over_scene():
	GlobalAudioPlayer.stop_stream()
	GlobalDataSaverLoader.new().save_scene()
	PlayerInventorySaverLoader.new().save_scene()
	get_tree().change_scene_to_file("res://levels/GameOver.tscn")


func _on_autosave_timeout() -> void:
	GlobalDataSaverLoader.new().save_scene()
	PlayerInventorySaverLoader.new().save_scene()
	auto_save_timer.start()
