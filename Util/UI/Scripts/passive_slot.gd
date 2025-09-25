extends PanelContainer

@onready var player = get_tree().get_first_node_in_group("Player")

@export var item : PassiveItem:
	set(value):
		item = value
		$TextureRect.texture = value.texture

func _ready() -> void:
	if item != null:
		item.player_reference = player
