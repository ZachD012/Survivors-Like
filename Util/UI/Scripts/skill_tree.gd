extends Control

@export var weapons : HBoxContainer
@export var passive_items : HBoxContainer

func _ready() -> void:
	hide()

func reset():
	for slot in weapons:
		var weapon : Weapon
		if weapon in slot:
			if weapon.starting_weapon:
				weapon.level = 1
		else:
			weapon.level = 0
	for slot in passive_items:
		var passive_item : PassiveItem
		if passive_item in slot:
			passive_items.level = 0
				

func close_tree():
	hide()
	get_tree().paused = false

func open_tree():
	show()
	get_tree().paused = true
