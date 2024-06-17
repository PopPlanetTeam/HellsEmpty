extends CharacterBody2D
class_name EnemyBase

signal enemy_killed

@export var speed: float = 100.0
@export var player: PlayerBase
@export var enemy_animated_sprite: AnimatedSprite2D

@export_group("Life and Damage")
@export var health_component: Health
@export var damage: float = 24.0

@export_group("Layers and Masks")
@export_flags_2d_physics var provides_collision = 0
@export_flags_2d_physics var scan_collision = 0
@export_flags_2d_physics var takes_damage = 0
@export_flags_2d_physics var provide_damage = 0

@onready var _life_bar = $Health/LifeBar
@onready var _hitbox = $HitBox

func _ready():
	_life_bar.max_value = health_component.life
	_life_bar.value = health_component.life

	# Set the collision layer and mask
	self.collision_layer = provides_collision
	self.collision_mask = scan_collision
	_hitbox.collision_layer = provide_damage
	_hitbox.collision_mask = takes_damage

func _process(delta):
	# if player:
	# 	var direction : Vector2 = (player.global_position - global_position).normalized()
		
	# 	# Do not go directly to the player, add some random noise to movement
	# 	if randf() < RANDOM_MOVEMENT_RATE:
	# 		movement_randomness = Vector2(randf_range(0.0, PI), randf_range(0.0, PI)).normalized() * 0.33
	# 	global_position += (direction + movement_randomness).normalized() * speed * delta
	
	_life_bar.value = health_component.life

func _on_damage_area_body_entered(body) -> void:
	if body.is_in_group("inflict_damage"):
		health_component.life -= body.damage
		body.queue_free()
		if health_component.life <= 0.0:
			enemy_killed.emit()
			queue_free()
			
