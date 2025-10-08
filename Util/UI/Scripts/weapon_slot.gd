extends PanelContainer

@onready var player = get_tree().get_first_node_in_group("Player")

var can_attack : bool = true
var clone : Weapon
var first_time : bool = true
@export var item : Weapon:
	set(value):
		if value == null:
			return
		item = value
		clone = value.duplicate(true) # keep a pristine version
		$TextureRect.texture = item.texture
		$Cooldown.wait_time = item.cooldown
		$TextureProgressBar.value = $Cooldown.time_left
		
func _physics_process(_delta: float) -> void:
	ability_check()
	$TextureProgressBar.value = $Cooldown.time_left

func _on_cooldown_timeout() -> void:
	can_attack = true
	if item != null and not item.ability_weapon:
		$Cooldown.wait_time = item.cooldown
		item.activate(player, player.nearest_enemy, get_tree())

func ability_check():
	if item == null or not item.ability_weapon:
		return
	if Input.is_action_just_pressed("ability") and item != null and item.ability_weapon != null and can_attack:
		can_attack = false
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
