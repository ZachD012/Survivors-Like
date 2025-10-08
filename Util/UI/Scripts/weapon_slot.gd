extends PanelContainer
class_name WeaponSlot

@onready var player = get_tree().get_first_node_in_group("Player")

var clone : Weapon
@export var item : Weapon:
	set(value):
		if value == null:
			return
		item = value
		clone = value.duplicate(true) # keep a pristine version
		$TextureRect.texture = item.texture
		$Cooldown.wait_time = item.cooldown

func _on_cooldown_timeout() -> void:
	if item != null and not item.ability_weapon:
		$Cooldown.wait_time = item.cooldown
		item.activate(player, player.nearest_enemy, get_tree())

func reset():
#	maybe instead do item.damage = clone.damage
	item.damage = clone.damage
	item.cooldown = clone.cooldown
	item.pierce = clone.pierce
	$Cooldown.wait_time = item.cooldown
	print("reset weapon: ", str(item), " in weapon slot: ", str(self))
	if not item.starting_weapon:
		queue_free()
		print("removed weapon_slot item")
