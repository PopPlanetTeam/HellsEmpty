extends Node2D
class_name EnemySpawner

@export var enemies_to_spawn : Array[PackedScene]
@export var closest_marker_points_to_consider : int = 3

@export var MAX_NUMBER_OF_ENEMIES : int = 3
@onready var number_of_enemies : int = 0

func _ready():
	pass

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if number_of_enemies < MAX_NUMBER_OF_ENEMIES:
		spawn_new_enemy()
		number_of_enemies += 1

func spawn_new_enemy() -> void:
	var scale = Vector2(2.2, 2.2)
	
	var enemy = enemies_to_spawn.pick_random().instantiate()
	
	enemy.global_position = get_position_to_spawn()
	enemy.scale = scale
	enemy.speed *= scale.x
	

	var enemy_died_signal = enemy.died
	enemy_died_signal.connect(spawn_new_enemy)
	#add_sibling(enemy)
	add_child(enemy)

# This function will get all the child markers, sort by distance to the player
# and choose one of the best 3 at random
func get_position_to_spawn() -> Vector2:
	var is_marker_2d_lambda = func(obect) -> bool : return obect is Marker2D
	var node_children : Array[Node] = get_children()
	var markers = get_children().filter(is_marker_2d_lambda) as Array[Marker2D]
	
	var player_position = GlobalData.player.global_position
	var sort_lamda = func(a, b) -> bool : return (a.global_position - player_position).length() < (b.global_position - player_position).length()
	markers.sort_custom(sort_lamda)
	
	var choosed_location : Marker2D = markers.slice(0, closest_marker_points_to_consider).pick_random()
	return choosed_location.global_position
