extends Area2D

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func cast():
	const FIREBALL = preload("res://scenes/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = %ShootingPoint.global_position
	new_fireball.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_fireball)

func _on_timer_timeout() -> void:
	cast()
