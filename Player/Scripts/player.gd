extends CharacterBody2D

signal health_depleted

@onready var weapons : HBoxContainer = %Weapons
@onready var passive_items : HBoxContainer = %PassiveItems
var area : float = 0
var starting_movement_speed = 100
var movement_speed = starting_movement_speed
var starting_health = 50
var health : float = starting_health:
	set(value):
		health = max(value, 0)
		%HealthBar.value = value
var starting_max_health = 50
var max_health : float = starting_max_health:
	set(value):
		max_health = value
		%HealthBar.max_value = value
var starting_recovery : float = 0.1
var recovery : float = starting_recovery
var starting_armor : float = 0
var armor : float = starting_armor

var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float = 150 + area

var experience : int = 0:
	set(value):
		experience = value
		%XP.value = value
var total_experience : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "Lvl " + str(value)
		%SkillTree.open_tree()
		#%Options.show_option()
		
		if level >= 3:
			%XP.max_value = 50
		elif level >= 7:
			%XP.max_value = 150
func _ready() -> void:
	print("health: ", str(health))
	print("armor: ", str(armor))
	print("recovery: ", str(recovery))
	
func _physics_process(_delta):
	#Checking if there is a nearest enemy then stores its seperation as the distance. Otherwise set the value to default (infinite)
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.seperation
	else:
		nearest_enemy_distance = 150 + area
		nearest_enemy = null
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * movement_speed
	move_and_slide()
	check_XP()
	health += recovery * _delta

func take_damage(amount):
	var damage = max(amount * (10/(armor+10)), 0)
	health -= damage
	print("Health: ", health, " Damage Taken: ", damage)
	if health <= 0.0:
		health_depleted.emit()

func _on_self_damage_body_entered(body):
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)

func gain_XP(amount):
	experience += amount
	total_experience += amount

func check_XP():
	if experience >= %XP.max_value:
		experience -= %XP.max_value
		level += 1

func reset_items():
	#var item_slots : Array[Node] = item_container.get_children()
	#for item_slot in item_slots:
		#item_slot.reset()
	for weapon_slot in weapons.get_children():
		weapon_slot.reset()
	for passive_slot in passive_items.get_children():
		passive_slot.reset()
	print("reset all item slots")

func reset_stats():
	health = starting_health
	max_health = starting_max_health
	movement_speed = starting_movement_speed
	recovery = starting_recovery
	armor = starting_armor

func reset():
	reset_items()
	reset_stats()

func _on_health_depleted() -> void:
	#On retry pressed in the game over screen, calls player reset() function.
	%GameOver.show()
	#Skill tree reset calls the reset function for every skill node in its children.
	%SkillTree.reset()
	get_tree().paused = true
