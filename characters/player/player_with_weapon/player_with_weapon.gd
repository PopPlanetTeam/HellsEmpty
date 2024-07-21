extends PlayerBase

@export var weapon_slot : WeaponSlot

func _ready():
	super._ready()

	# Await these nodes to be ready, they perform important validations
	await weapon_slot.ready
	await animation_player.ready

	# Verificar se há arma no slot
	if not weapon_slot.has_weapon():
		# Mudamos para o player sem arma
		var player_no_weapon : PlayerBase = GlobalData.player_no_weapon_scene.instantiate()
		
		player_no_weapon.global_position = self.global_position
		
		self.get_parent().call_deferred("add_child", player_no_weapon)
		self.queue_free()
