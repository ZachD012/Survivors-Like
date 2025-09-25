extends Control

@export var weapons : HBoxContainer
@export var passive_items : HBoxContainer

func _ready() -> void:
	hide()

func close_tree():
	hide()
	get_tree().paused = false

func open_tree():
	show()
	get_tree().paused = true
