extends Node2D

@export var contents: Array = []

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _area_2d: Area2D = $Area2D

var _can_open: bool = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):
		print(contents)

		if _can_open:
			_sprite.frame = 1

			# Spit out contents like an explosion [TODO]

			_area_2d.monitoring = false


func _on_area_2d_area_exited(_area):
	_can_open = false

func _on_area_2d_area_entered(_area):
	_can_open = true
