extends CharacterBody2D

var move_speed = 100

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * move_speed
	move_and_slide()
