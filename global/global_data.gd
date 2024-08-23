extends Node

var player: PlayerBase

var player_no_weapon_scene: PackedScene = preload("res://characters/player/player_no_weapon/player_no_weapon.tscn")
var player_with_weapon_scene: PackedScene = preload("res://characters/player/player_with_weapon/player_with_weapon.tscn")

var enemies_scenes: Array[PackedScene] = [
	preload("res://characters/enemies/luna/luna.tscn"),
	preload("res://characters/enemies/owlet/owlet.tscn")
]

const DAMAGE_GROUP = "damage_body"
const WEAPON_SAVE_GROUP = "weapon_save"
const WEAPON_CONTAINER_SELECTION_AREA_GROUP = "weapon_container_selection_area"
