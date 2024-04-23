extends Node2D

var limit = 20
var qtd_enemies = 0
var killed_enemies : int = 0
var viewport_size = get_viewport_rect().size
@onready var audio = $Audio
@onready var camera = $Camera2D
@onready var label = $Camera2D/Label
var player : Player

func _ready():
	TranslationServer.set_locale("us")
	remove_child(camera)
	player = load("res://player/player.tscn").instantiate()
	player.life = 100.0
	player.add_child(camera)
	add_child(player)
	viewport_size = get_viewport_rect().size
	
func _process(delta):
	if qtd_enemies < limit:
		qtd_enemies += 1
		var position = Vector2().from_angle(randf_range(0, 2*PI)) * viewport_size
		var enemy = load("res://enemy/enemy.tscn").instantiate()
		enemy.position = position + player.position
		enemy.connect("enemy_killed", _on_enemy_killed)
		self.add_child(enemy)
	
	label.text = tr("COLLECTED_SOULS") + ": " + str(killed_enemies)

func _on_audio_finished():
	audio.play()

func _on_game_limits_body_exited(body:Node2D) -> void:
	body.queue_free()

func _on_enemy_killed():
	self.qtd_enemies -= 1
	self.killed_enemies += 1
	
	# Every 50 enemies killed the number of spawned enemies increase by 5
	if self.killed_enemies % 50 == 0 and self.limit < 100:
		self.limit += 5
		print("Increased by 5! limit: ", self.limit)
