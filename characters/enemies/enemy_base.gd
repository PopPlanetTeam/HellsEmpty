extends CharacterBody2D
class_name EnemyBase

@export var speed: float = 100.0
@export var player: PlayerBase
@export var state_machine: StateMachine

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

func _process(_delta):
	_life_bar.value = health_component.life

# Take damage
func _on_hit_box_area_entered(area):
	_hitbox.take_damage(area.damage)
