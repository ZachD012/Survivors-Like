extends PanelContainer

@onready var player = get_tree().get_first_node_in_group("Player")

var can_attack : bool = true
@export var item : Weapon:
	set(value):
		item = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown
		
func _process(delta: float) -> void:
	ability_check()

func _on_cooldown_timeout() -> void:
	can_attack = true
	if item != null and not item.ability_weapon:
		$Cooldown.wait_time = item.cooldown
		item.activate(player, player.nearest_enemy, get_tree())

func ability_check():
	if Input.is_action_pressed("ability") and item != null and item.ability_weapon != null and can_attack:
		can_attack = false
		$Cooldown.wait_time = item.cooldown
		item.activate(player, player.nearest_enemy, get_tree())
