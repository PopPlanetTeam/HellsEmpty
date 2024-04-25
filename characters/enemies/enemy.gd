extends CharacterBody2D

@onready var game = get_parent()
@onready var sprite = $Sprite
@onready var player = game.get_node("PlayerWithWeapon")
var sprite_texture
var speed = 100
@export var life: float = 100.0;
@export var damage: float = 24.0;

const RANDOM_MOVEMENT_RATE: float = 0.05
var movement_randomness:Vector2 = Vector2(0.0, 0.0)

signal enemy_killed

func _ready():
	var rand = randi_range(0, 5)
	sprite.texture = load("res://enemy/imgs/enemy_" + str(rand) + "-Sheet.png")
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
			
