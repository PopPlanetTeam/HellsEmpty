extends Node2D
class_name EnemySpawner

@export var enemies_to_spawn : Array[PackedScene]
@export var closest_marker_points_to_consider : int = 3

@export var MAX_NUMBER_OF_ENEMIES : int = 3
@onready var number_of_enemies : int = 0

func _ready():
	for i in range(number_of_enemies, MAX_NUMBER_OF_ENEMIES):
		spawn_new_enemy() 

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if number_of_enemies < MAX_NUMBER_OF_ENEMIES:
		#spawn_new_enemy()
		#number_of_enemies += 1
		pass

func spawn_new_enemy() -> void:
	var scale = Vector2(2.2, 2.2)
	
	var enemy = enemies_to_spawn.pick_random().instantiate()
	
	enemy.global_position = get_position_to_spawn()
	enemy.scale = scale
	enemy.speed *= scale.x
	
	var enemy_died_signal = enemy.died
	enemy_died_signal.connect(spawn_new_enemy)
	add_child(enemy)
	number_of_enemies += 1

func get_position_to_spawn() -> Vector2:
	var is_marker_2d_lambda = func(obect) -> bool : return obect is Marker2D
	var node_children : Array[Node] = get_children()
	var markers = get_children().filter(is_marker_2d_lambda) as Array[Marker2D]
	
	var player_position = GlobalData.player.global_position
	var sort_lamda = func(a, b) -> bool : return (a.global_position - player_position).length() < (b.global_position - player_position).length()
	markers.sort_custom(sort_lamda)
	
	var choosed_location : Marker2D = markers.slice(0, closest_marker_points_to_consider).pick_random()
	
	var p1 : Vector2 = markers.slice(0, closest_marker_points_to_consider).pick_random().global_position
	var p2 : Vector2 = markers.slice(0, closest_marker_points_to_consider).pick_random().global_position
	
	var scale_factor = randf()
	
	var position = (p1-p2) * scale_factor
	
	#const minimum_distance = 500
	#
	#var _dist = position - player_position
	#if _dist.length() < minimum_distance:
		#print("Too close")
		#position += _dist.normalized() * minimum_distance
	
	return position
