extends CharacterBody2D

@export var player_reference : CharacterBody2D
@onready var player = get_node("/root/Main/PlayerHuman")

var damage : float
var knockback : Vector2
var seperation : float
var health : float:
	set(value):
		health = value
		if health <= 0:
			queue_free()
const SPEED = 38.0

var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage
		health = value.health
	

func _physics_process(delta):
	velocity = (player_reference.position - position).normalized() * SPEED
	move_and_collide(velocity * delta)
		
func take_damage():
	health -= 1
	
	if health == 0:
		queue_free()

func check_seperation(_delta):
	seperation = (player_reference.position - position).length()
	
