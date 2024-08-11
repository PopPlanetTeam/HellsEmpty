extends Node2D

@export var contents: Array[PackedScene]

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _area_2d: Area2D = $Area2D
@onready var _opening_sound : AudioStreamPlayer2D = $OpeningSound

var _can_open: bool = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):
		print(contents)

		if _can_open:
			_sprite.frame = 1
			
			_opening_sound.play()

			# Spit out contents like an explosion
			var pickup_spawner: PackedScene = preload("res://components/map/chests/pickups_spawner.tscn")
			
			for content in contents:
				var spawner = pickup_spawner.instantiate()
				spawner.global_position = global_position
				spawner.content = content
				get_parent().call_deferred("add_child", spawner)

			_area_2d.monitoring = false


func _on_area_2d_area_exited(_area):
	_can_open = false

func _on_area_2d_area_entered(_area):
	_can_open = true
