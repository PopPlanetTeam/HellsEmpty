extends SceneBase

@onready var camera : Camera2D = $Camera2D
@onready var enemy_spawn : EnemySpawnerDesert = $EnemySpawn

func _ready():
	super._ready()
	enemy_spawn.spawn_enemies()
	
	SceneManager.player_transition.player_died.connect(_game_over_scene)
	
func _game_over_scene():
	GlobalAudioPlayer.stop_stream()
	GlobalDataSaverLoader.new().save_scene()
	PlayerInventorySaverLoader.new().save_scene()
	get_tree().change_scene_to_file("res://levels/GameOver.tscn")
