extends Item
class_name PassiveItem

@export var upgrades : Array[Stats]
var player_reference

func reset():
	level = 0

func is_upgradable() -> bool:
	if level <= upgrades.size():
		return true
	return false

func upgrade_item():
	if not is_upgradable():
		return
	
	if player_reference == null:
		return
	
	var upgrade = upgrades[level -1]
	
	player_reference.max_health += upgrade.max_health
	player_reference.recovery += upgrade.recovery
	player_reference.armor += upgrade.armor
	player_reference.movement_speed += upgrade.movement_speed
	
	level += 1
	print("max health: ", player_reference.max_health)
	print("recovery: ", player_reference.recovery)
	print("armor: ", player_reference.armor)
