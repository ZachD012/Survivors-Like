extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene

#how far to spawn from player
var distance : float = 200

@export var enemy_types : Array[Enemy]

var minute : int:
	set(value):
		minute = value
		%Minute.text = str(value)

var second : int:
	set(value):
		second = value
		if second >= 60:
			second -= 60
			minute +=1
		%Second.text = str(second).lpad(2, '0') #set padding

func spawn(pos : Vector2):
	var enemy_instance = enemy.instantiate()
	
	#each minute is a different wave of enemy
	enemy_instance.type = enemy_types[min(minute, enemy_types.size()-1)]
	enemy_instance.position = pos
	enemy_instance.player_reference = player
	
	get_tree().current_scene.add_child(enemy_instance)
#get random position from player at a certain distance. (random points from circle with radius of 'distance' and player position as the center)
func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number : int = 1):
	for i in range(number):
		spawn(get_random_position())


func _on_timer_timeout() -> void:
	second += 1
	amount(second % 10) #increment second with each timeout and spawn enemies
