extends Node2D

@onready var _sprite = $AnimatedSprite2D

func _ready():
	var animations: PackedStringArray = (_sprite.sprite_frames as SpriteFrames).get_animation_names()
	var animation_to_play = animations[randi_range(0, animations.size() - 1)]
	
	_sprite.animation = animation_to_play

func _on_audio_stream_player_2d_finished():
	self.queue_free()
