extends Area2D

var travelled_distance = 0

var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage : float = 1

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
#func _physics_process(delta: float) -> void:
	#const SPEED = 200
	#const RANGE = 700
	#
	#var direction = Vector2.RIGHT.rotated(rotation)
	#position += direction * SPEED * delta
	#
	#travelled_distance += SPEED * delta
	#if travelled_distance > RANGE:
		#queue_free()
#
#
#func _on_body_entered(body: Node2D) -> void:
	#queue_free()
	#if body.has_method("take_damage"):
		#body.take_damage()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pass # Replace with function body.
