extends Item
class_name Weapon

@export var damage : float
@export var cooldown : float
@export var speed : float
@export var pierce : int
@export var ability_weapon : bool = false
@export var projectile_node : PackedScene
@export var area_of_effect : float
@export var starting_weapon : bool
var player_reference

@export var upgrades : Array[Upgrade]


func activate(_source, _target, _scene_tree):
	pass

func is_upgradable() -> bool:
	if level <= upgrades.size():
		return true
	return false
	
func upgrade_item():
	if not is_upgradable():
		return
	var upgrade = upgrades[level -1]
	
	#since this is a base resource, update common stats (override function in concrete classes to upgrade exclusive stats)
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	pierce += upgrade.pierce
	
	level += 1
	
	_child_upgrade(upgrade)

func _child_upgrade(upgrade):
	pass
