extends CharacterBody2D

signal health_depleted
var move_speed = 100
var health = 100.0:
	set(value):
		health = value
		%HealthBar.value = value

var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float = INF

func _physics_process(_delta):
	#Checking if there is a nearest enemy then stores its seperation as the distance. Otherwise set the value to default (infinite)
	if nearest_enemy:
		nearest_enemy_distance = nearest_enemy.seperation
		print(nearest_enemy.name)
	else:
		nearest_enemy_distance = INF
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * move_speed
	move_and_slide()

	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()

	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * _delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()

func take_damage(amount):
	health -= amount

func _on_self_damage_body_entered(body):
	take_damage(body.damage)
