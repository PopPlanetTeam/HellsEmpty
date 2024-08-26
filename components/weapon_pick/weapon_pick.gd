extends Node2D
class_name WeaponPick

@export var weapon: PackedScene
@onready var area_2d: Area2D = $Area2D

var player: PlayerBase

func _ready():
	area_2d.monitorable = false
	area_2d.monitoring = true
	
	set_process_input(false)

func _input(event):
	if event.is_action_pressed("ui_select"):
		player.pick_weapon(self)

func get_weapon() -> PackedScene:
	return weapon

func set_enabled(enabled: bool):
	area_2d.monitoring = enabled
	area_2d.monitorable = enabled

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent_obj = area.get_parent()
	player = parent_obj
	
	if parent_obj is PlayerWithWeapon:
		set_process_input(true)
	else:
		player.pick_weapon(self)

func _on_area_2d_area_exited(area: Area2D) -> void:
	set_process_input(false)
