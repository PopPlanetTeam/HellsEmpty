extends Node

var player: PlayerBase

var player_no_weapon_scene: PackedScene = preload("res://characters/player/player_no_weapon/player_no_weapon.tscn")
var player_with_weapon_scene: PackedScene = preload("res://characters/player/player_with_weapon/player_with_weapon.tscn")

const DAMAGE_GROUP = "damage_body"

var pause_menu: PackedScene = preload('res://menus/pause_menu/pause_menu.tscn')
var is_paused: bool = false

func _input(event) -> void:
	if Input.is_action_just_pressed('toggle_fullscreen'):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
