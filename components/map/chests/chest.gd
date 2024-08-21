extends Node2D

@export var contents: Array[ChestItem]

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _area_2d: Area2D = $Area2D
@onready var _opening_sound : AudioStreamPlayer2D = $OpeningSound

var _can_open: bool = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_select"):
		if _can_open:
			_sprite.frame = 1
			
			_opening_sound.play()

			# Spit out contents like an explosion
			var pickup_spawner: PackedScene = preload("res://components/map/chests/pickups_spawner/pickups_spawner.tscn")
			
			for item in contents:
				for i in range(item.number_of_items):
					var pickup_spawner_instance = pickup_spawner.instantiate()

					pickup_spawner_instance.global_position = self.global_position
					pickup_spawner_instance.content = item.item_scene
					
					get_parent().call_deferred("add_child", pickup_spawner_instance)

			_area_2d.monitoring = false


func _on_area_2d_area_exited(_area):
	_can_open = false

func _on_area_2d_area_entered(_area):
	_can_open = true
