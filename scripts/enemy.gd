extends CharacterBody2D

@export var player_reference : CharacterBody2D
var damage_popup_node = preload("res://scenes/damage.tscn")
var direction : Vector2
var damage : float
var knockback : Vector2
var seperation : float
var experience : float
var health : float:
	set(value):
		health = value
		if health <= 0:
			player_reference.experience += experience
			queue_free()
const SPEED = 38.0

var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://Shaders/Red.tres")
			scale = Vector2(1.5,1.5)
			health *= 5
			damage *= 5
			experience *= 5
			
var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage
		health = value.health
		experience = value.experience

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
		
func take_damage(amount):
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate",Color(255, 255, 255), 0.2)
	tween.chain().tween_property($Sprite2D, "modulate",Color(1, 1, 1), 0.2)
	tween.bind_node(self)#binds it to enemy so when they die it doesnt throw errors
	damage_popup(amount)
	health -= amount

func check_seperation(_delta):
	#if more than 500 away from player, free from memory if they are not elite
	seperation = (player_reference.position - position).length()
	if seperation >= 500 and not elite:
		queue_free()
	
	#if any enemy is nearer to the player, update
	if seperation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self

func damage_popup(amount):
	var popup = damage_popup_node.instantiate()
	popup.text = str(int(amount))
	popup.position = position + Vector2(-50, -25)
	get_tree().current_scene.add_child(popup)
