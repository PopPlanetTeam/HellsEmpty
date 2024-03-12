extends Node2D

var limit = 20
var qtd_enemies = 0
var killed_enemies = 0
var viewport_size = get_viewport_rect().size
@onready var audio = $Audio
@onready var label = $player/Label

func _ready():
	viewport_size = get_viewport_rect().size

func _process(delta):
	if qtd_enemies < limit:
		qtd_enemies += 1
		var random_x = randf_range(0, viewport_size.x)
		var random_y = randf_range(0, viewport_size.y)
		var enemy = load("res://enemy/enemy.tscn").instantiate()
		enemy.position = Vector2(random_x, random_y)
		self.add_child(enemy)
	label.text = "Almas coletadas = " + str(killed_enemies)

func _on_audio_finished():
	audio.play()

func _on_game_limits_body_exited(body:Node2D) -> void:
	body.queue_free()
