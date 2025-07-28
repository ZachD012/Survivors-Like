extends Area2D
class_name Projectile

var travelled_distance = 0

var direction : Vector2 = Vector2.RIGHT
var speed : float
var damage : float
var pierce : int
var pierce_count: int = 0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and pierce_count <= pierce:
		pierce_count += 1
		body.take_damage(damage)
		body.knockback = direction * 50
		if pierce_count == pierce:
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
