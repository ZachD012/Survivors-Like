extends Control

@export var weapon_container : HBoxContainer
@export var passive_item_container : HBoxContainer

func reset():
	for node in get_children():
		if node is SkillNode:
			node.reset()

func _ready() -> void:
	hide()
	
func close_tree():
	hide()
	get_tree().paused = false

func open_tree():
	show()
	get_tree().paused = true
