extends CharacterBody2D

signal health_depleted
var area : float = 0
var move_speed = 100
var health = 100.0:
	set(value):
		health = value
		%HealthBar.value = value

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
		
		if level >= 3:
			%XP.max_value = 25
		elif level >= 7:
			%XP.max_value = 50

func _physics_process(_delta):
	#Checking if there is a nearest enemy then stores its seperation as the distance. Otherwise set the value to default (infinite)
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.seperation
	else:
		nearest_enemy_distance = 150 + area
		nearest_enemy = null
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * move_speed
	move_and_slide()
	check_XP()

func take_damage(amount):
	health -= amount
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
