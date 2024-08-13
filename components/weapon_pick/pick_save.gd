extends Node2D
class_name PickSave

func save(weapons_array: Array):
	if has_node("Picker"):
		var weapon_save = WeaponSave.new()
		
		weapon_save.node_name = self.name

		weapons_array.append(weapon_save)
