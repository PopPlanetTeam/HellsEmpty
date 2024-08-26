extends SceneBase

@onready var camera : Camera2D = $Camera2D
@onready var enemy_spawn : EnemySpawnerDesert = $EnemySpawn

func _ready():
	super._ready()
	enemy_spawn.spawn_enemies()
