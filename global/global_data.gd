extends Node

var player: PlayerBase

var player_no_weapon_scene: PackedScene = preload("res://characters/player/player_no_weapon/player_no_weapon.tscn")
var player_with_weapon_scene: PackedScene = preload("res://characters/player/player_with_weapon/player_with_weapon.tscn")

var enemies_scenes: Array[PackedScene] = [
	preload("res://characters/enemies/luna/luna.tscn"),
	preload("res://characters/enemies/owlet/owlet.tscn")
]

const PHASE_SCENE = "phase"
const DAMAGE_GROUP = "damage_body"

const WEAPON_SAVE_GROUP = "weapon_save"
const CHEST_SAVE_GROUP = "chest_save"
const ENEMY_SPAWN_GROUP = "enemy_spawn"

var level_enemies_killed: int = 0
var total_enemies_killed: int = 0