extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene

#how far to spawn from player
var distance : float = 200
var can_spawn : bool = true
var mob_cap : int = 600

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

func _physics_process(delta: float) -> void:
	if get_tree().get_node_count_in_group("Enemy") < mob_cap:
		can_spawn = true
	else:
		can_spawn = false


func spawn(pos : Vector2, elite : bool = false):
	if not can_spawn and not elite:
		return
	
	var enemy_instance = enemy.instantiate()
	
	#each minute is a different wave of enemy
	enemy_instance.type = enemy_types[min(minute, enemy_types.size()-1)]
	enemy_instance.position = pos
	enemy_instance.player_reference = player
	enemy_instance.elite = elite
	
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


func _on_pattern_timeout() -> void:
	for i in range(75):
		spawn(get_random_position())


func _on_elite_timeout() -> void:
	spawn(get_random_position(), true)
