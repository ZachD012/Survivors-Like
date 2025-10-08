extends PanelContainer

@onready var player = get_tree().get_first_node_in_group("Player")
var clone : PassiveItem
@export var item : PassiveItem:
	set(value):
		item = value
		clone = value.duplicate(true) # keep a pristine version
		$TextureRect.texture = value.texture

func _ready() -> void:
	if item != null:
		item.player_reference = player

func reset():
	item.reset()
