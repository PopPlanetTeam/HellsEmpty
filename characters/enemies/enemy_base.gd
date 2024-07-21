extends CharacterBody2D
class_name EnemyBase

@export var speed: float = 100.0
@export var distance_threshold: float = 100.0
@export var state_machine: StateMachine
@export var obstacle_detector: ObstacleDetector

@export_group("Life and Damage")
@export var health_component: Health
@export var damage: float = 24.0

@export_group("Layers and Masks")
@export_flags_2d_physics var provides_collision = 0
@export_flags_2d_physics var scan_collision = 0
@export_flags_2d_physics var takes_damage = 0
@export_flags_2d_physics var provide_damage = 0

@onready var _hitbox = $HitBox
@onready var _damage_area = $DamageArea

func _ready():
	# Set the collision layer and mask
	self.collision_layer = provides_collision
	self.collision_mask = scan_collision
	_hitbox.collision_layer = takes_damage
	_hitbox.collision_mask = 0 # The hitbox will not collide with anything, it needs to only be visible to damage areas
	_damage_area.collision_layer = 0 # The damage area will not collide with anything, it only needs to search for hitboxes
	_damage_area.collision_mask = provide_damage

	# Set collision mask of obstacle detector
	obstacle_detector.collision_mask = scan_collision

func _on_died():
	self.queue_free()
