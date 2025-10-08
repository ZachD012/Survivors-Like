extends WeaponSlot
class_name ActiveWeaponSlot

var can_attack : bool = true

func _ready() -> void:
	$TextureRect/CooldownBar.max_value = $Cooldown.wait_time
func _process(delta: float) -> void:
	$TextureRect/CooldownBar.value = $Cooldown.time_left

func _physics_process(_delta: float) -> void:
	ability_check()

#had to make a seperate instance of this timer because they dont get overridden from what I can tell
func _on_cooldown_timeout() -> void:
	can_attack = true
	$Cooldown.wait_time = item.cooldown

func ability_check():
	if Input.is_action_just_pressed("ability") and item != null and can_attack:
		can_attack = false
		$Cooldown.wait_time = item.cooldown
		$TextureRect/CooldownBar.max_value = $Cooldown.wait_time
		item.activate(player, player.nearest_enemy, get_tree())
		$Cooldown.start()
	elif Input.is_action_just_pressed("ability") and item != null and not can_attack:
		print("cant attack becasue variable throws false still", str(can_attack))
