extends CharacterBody2D

signal health_depleted
var health = 100.0
var move_speed = 100

func _physics_process(_delta):
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
