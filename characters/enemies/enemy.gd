extends CharacterBody2D
class_name EnemyBase

@export_group("Life and Damage")
@export var life: float = 100.0
@export var damage: float = 24.0

@export var enemy_texture: Texture2D
@export var player: PlayerBase

@export_group("Layers and Masks")
@export_flags_2d_physics var provides_collision = 0b001
@export_flags_2d_physics var scan_collision = 0
@export_flags_2d_physics var takes_damage = 0
@export_flags_2d_physics var provide_damage = 0

@onready var sprite_node = $Sprite
var sprite_texture
var speed = 100

const RANDOM_MOVEMENT_RATE: float = 0.05
var movement_randomness:Vector2 = Vector2(0.0, 0.0)

signal enemy_killed

func _ready():
	var rand = randi_range(0, 5)
	sprite_node.texture = load("res://enemy/imgs/enemy_" + str(rand) + "-Sheet.png")
	match rand:
		1:
			speed = randi_range(120, 170)
		2:
			speed = randi_range(120, 140)
		3:
			speed = randi_range(80, 100)
		_:
			speed = randi_range(80, 120)

func _process(delta):
	if player:
		var direction : Vector2 = (player.global_position - global_position).normalized()
		
		# Do not go directly to the player, add some random noise to movement
		if randf() < RANDOM_MOVEMENT_RATE:
			movement_randomness = Vector2(randf_range(0.0, PI), randf_range(0.0, PI)).normalized() * 0.33
		global_position += (direction + movement_randomness).normalized() * speed * delta
	
	$ProgressBar.value = life

func _on_damage_area_body_entered(body) -> void:
	if body.is_in_group("inflict_damage"):
		life -= body.damage
		body.queue_free()
		if life <= 0.0:
			enemy_killed.emit()
			queue_free()
			
