extends PanelContainer

var can_attack : bool = true
@export var weapon : Weapon:
	set(value):
		weapon = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown
		
func _process(delta: float) -> void:
	if Input.is_action_pressed("ability") and weapon.ability_weapon and can_attack:
		can_attack = false
		$Cooldown.wait_time = weapon.cooldown
		print("activated")
		weapon.activate(owner, owner.nearest_enemy, get_tree())

func _on_cooldown_timeout() -> void:
	can_attack = true
	if not weapon.ability_weapon:
		$Cooldown.wait_time = weapon.cooldown
		weapon.activate(owner, owner.nearest_enemy, get_tree())
