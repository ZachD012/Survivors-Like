extends TextureButton
class_name SkillNode

@export var skill_item: Item 
@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/Label
@onready var line_2d: Line2D = $Line2D
@onready var skill_tree = get_owner()
var clone
		
func _ready() -> void:
	if skill_item != null:
		$Description.text = skill_item.upgrades[max(skill_item.level - 1, 0)].description
	$DescriptionBox.hide()
	$Description.hide()
	#if parent is a SkillNode then we draw a line between them
	if get_parent() is SkillNode:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)
	if skill_item != null:
		level = skill_item.level
		texture_normal = skill_item.texture
	
	var skills = get_children()
	for skill in skills:
		if skill is SkillNode and level == 1:
			skill.disabled = false
		elif skill is SkillNode and level < 1:
			skill.disabled = true
	clone = self.duplicate()

func reset():
	if skill_item.starting_weapon:
		level = 1
	else:
		level = 0
	if skill_item.has_method("reset"):
		skill_item.reset()

var level :int :
	set(value):
		level = value
		if level >= 1:
			panel.show_behind_parent = true
			line_2d.default_color = Color(1, 0.498039, 0.313726, 1)
		label.text = str(level) + "/3"

func _on_pressed() -> void:
	level = min(level + 1, 3)
	if level == 1:
		give_item(skill_item)
	elif level > 1:
		level_up_item(skill_item)
	
	var skills = get_children()
	for skill in skills:
		if skill is SkillNode and level == 1:
			skill.disabled = false
	
	skill_tree.close_tree()

func give_item(item):
#	wont work need to instantiate a slot into weapons and passive item as a child then
#	assign its item property as a weapon or passive item respectively
	if item is Weapon:
		var weapon_slot = preload("res://Util/UI/Scenes/weapon_slot.tscn").instantiate()
		weapon_slot.item = item
		if skill_tree.weapon_container != null:
			skill_tree.weapon_container.add_child(weapon_slot)
			print("gave weapon item: ", str(item))
	elif item is PassiveItem:
		var passive_slot = preload("res://Util/UI/Scenes/passive_slot.tscn").instantiate()
		passive_slot.item = item
		if skill_tree.passive_item_container != null:
			skill_tree.passive_item_container.add_child(passive_slot)
			print("gave passive item: ", str(item))

func level_up_item(item):
	item.upgrade_item()
	print("upgraded item: ", str(item))


func _on_mouse_entered() -> void:
	$DescriptionBox.show()
	$Description.show()
	$DescriptionBox.z_index = 1
	$Description.z_index = 1
	z_index = 2

func _on_mouse_exited() -> void:
	$DescriptionBox.hide()
	$Description.hide()
	$DescriptionBox.z_index = 0
	$Description.z_index = 0
	z_index = 0
