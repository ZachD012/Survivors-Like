extends VBoxContainer

@export var weapons : HBoxContainer
var OptionSlot = preload("res://Util/UI/Scenes/option_slot.tscn")

@export var panel : NinePatchRect

func _ready() -> void:
	hide()
	panel.hide()

func close_option():
	hide()
	panel.hide()
	get_tree().paused = false
	
func get_available_weapons():
	var weapon_resource = []
	for weapon in weapons.get_children():
		if weapon.weapon != null:
			weapon_resource.append(weapon.weapon)
	return weapon_resource

func show_option():
	var weapons_available = get_available_weapons()
	if weapons_available.size() == 0:
		return
		
	#if there is any weapon, then remove previous options/slots to reset and then update based on the weapons_avaiable array
	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	for weapon in weapons_available:
		if weapon.is_upgradable():
			var option_slot = OptionSlot.instantiate()
			option_slot.weapon = weapon
			#adding back slot here
			add_child(option_slot)
			option_size += 1
			
	if option_size == 0:
		return
	
	show()
	panel.show()
	get_tree().paused = true
