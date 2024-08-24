extends CharacterBody2D
class_name EnemyBase

signal died

@export var speed: float = 100.0
@export var chase_distance: float = 100.0 :
	get:
		return chase_distance * transform.get_scale().x

@export var run_away_distance: float = 200.0 :
	get:
		return run_away_distance * transform.get_scale().x

@export_group("Animation")
@export var animation_sprites: AnimatedSprite2D

@export_group("Attack")
@export var distance_to_attack: float = 60.0
@export var damage: float = 24.0
@export var knockback_strength: float = 100.0

@export_group("Layers and Masks")
@export_flags_2d_physics var provides_collision = 0
@export_flags_2d_physics var scan_collision = 0
@export_flags_2d_physics var takes_damage = 0
@export_flags_2d_physics var provide_damage = 0

@export_group("Drops")
@export var number_of_drops: int = 1
@export var possible_drops: Array[DropItem]

@onready var hitbox: HitBox = $HitBox
@onready var damage_area: DamageArea = $DamageArea
@onready var health_component: Health = $Health
@onready var state_machine: StateMachine = $StateMachine

# Used to store the knockback force the enemy will receive
var _knockback: Vector2 = Vector2.ZERO

func _ready():
	# Set collision layers and masks
	self.collision_layer = provides_collision
	self.collision_mask = scan_collision
	hitbox.collision_layer = takes_damage
	hitbox.collision_mask = takes_damage
	damage_area.collision_layer = 0 # The damage area will not collide with anything, it only needs to search for hitboxes
	damage_area.collision_mask = provide_damage
	damage_area.monitoring = false # The damage area will not be active until the enemy attacks
	damage_area.damage = damage
	damage_area.knockback_strength = knockback_strength

func _drop_item():
	var item_dropper_scene = preload("res://components/item_dropper/item_dropper.tscn")

	var random_val = randf()
	var cumulative_probability = 0.0

	for drop in possible_drops:
		cumulative_probability += drop.probability

		if random_val > cumulative_probability:
			continue

		var amount = randi_range(drop.min_amount, drop.max_amount)
		var item = drop.item_scene

		for i in range(amount):
			var item_dropper = item_dropper_scene.instantiate()

			item_dropper.content = item
			item_dropper.global_position = self.global_position

			get_parent().call_deferred("add_child", item_dropper)
		
		break

var enemy_died: bool = false
func _on_died():
	if enemy_died:
		return
	
	died.emit()
	
	enemy_died = true
	
	GlobalData.level_enemies_killed += 1
	GlobalData.total_enemies_killed += 1

	for i in range(number_of_drops):
		_drop_item()

	self.queue_free()

func _physics_process(_delta):
	if not _knockback.is_equal_approx(Vector2.ZERO):
		self.velocity += _knockback

		self.move_and_slide()

		_knockback = _knockback.lerp(Vector2.ZERO, 0.5)
