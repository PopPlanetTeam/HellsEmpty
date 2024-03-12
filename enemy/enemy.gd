extends CharacterBody2D

@onready var game = get_parent()
@onready var sprite = $Sprite
@onready var player = game.get_node("player")
var sprite_texture
var speed = 100

const RANDOM_MOVEMENT_RATE: float = 0.05
var movement_randomness:Vector2 = Vector2(0.0, 0.0)

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
			movement_randomness = Vector2(randf_range(0.0, PI), randf_range(0.0, PI)).normalized() * randf()
		global_position += (direction + movement_randomness).normalized() * speed * delta
	else:
		print("Not player")

func _on_damage_area_body_entered(body) -> void:
	body.queue_free()
	game.qtd_enemies -= 1
	game.killed_enemies += 1
	queue_free()
