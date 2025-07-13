extends CharacterBody2D

@export var move_speed : float = 50
@export var starting_direction : Vector2 = Vector2(0, 1)
#parameters/Idle/blend_position

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * _delta
	move_and_slide()
