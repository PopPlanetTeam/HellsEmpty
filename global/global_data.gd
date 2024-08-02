extends Node

var player: PlayerBase

var player_no_weapon_scene: PackedScene = preload("res://characters/player/player_no_weapon/player_no_weapon.tscn")
var player_with_weapon_scene: PackedScene = preload("res://characters/player/player_with_weapon/player_with_weapon.tscn")

const DAMAGE_GROUP = "damage_body"