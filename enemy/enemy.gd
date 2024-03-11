extends CharacterBody2D

@onready var game = get_parent()
@onready var sprite = $Sprite
@onready var player = game.get_node("player")
var sprite_texture
var speed = 100

func _ready():
	var rand = randi_range(0, 5)
	sprite.texture = load("res://enemy/imgs/enemy_" + str(rand) + "-Sheet.png")
	
func _process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * speed * delta

func _on_damage_area_area_entered(area):
	game.qtd_enemies -= 1
	game.killed_enemies += 1
	queue_free()
