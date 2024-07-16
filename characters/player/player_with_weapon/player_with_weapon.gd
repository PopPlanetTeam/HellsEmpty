extends PlayerBase

@export var weapon_slot : WeaponSlot

@onready var _player_without_weapon = preload("res://characters/player/player_no_weapon/player_no_weapon.tscn")

func _ready():
	super._ready()

	# Verificar se há arma no slot
	if not weapon_slot.has_weapon():
		# Mudamos para o player sem arma
		var player_no_weapon : PlayerBase = _player_without_weapon.instantiate()
		
		player_no_weapon.global_position = self.global_position
		
		self.get_parent().call_deferred("add_child", player_no_weapon)
		self.queue_free()
