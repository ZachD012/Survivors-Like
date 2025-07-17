extends CharacterBody2D

@export var player_reference : CharacterBody2D
@onready var player = get_node("/root/Main/PlayerHuman")

var direction : Vector2
var damage : float
var knockback : Vector2
var seperation : float
var health : float:
	set(value):
		health = value
		if health <= 0:
			queue_free()
const SPEED = 38.0

var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://Shaders/Red.tres")
			scale = Vector2(1.5,1.5)
			health *= 10
			damage *= 10

var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage
		health = value.health

func _physics_process(delta):	
	check_seperation(delta)
	knockback_update(delta)

func knockback_update(delta):
	velocity = (player_reference.position - position).normalized() * SPEED
	knockback = knockback.move_toward(Vector2.ZERO, 1) #Decays over time
	velocity += knockback
	
	var collider = move_and_collide(velocity * delta)
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position - 
		global_position).normalized() * 50 #applies knockback to bodies colliding with enemy
		
func take_damage():
	health -= 1
	
	if health == 0:
		queue_free()

func check_seperation(_delta):
	#if more than 500 away from player, free from memory if they are not elite
	seperation = (player_reference.position - position).length()
	if seperation >= 500 and not elite:
		queue_free()
	
	#if any enemy is nearer to the player, update
	if seperation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self
