extends Area2D

var travelled_distance = 0

var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage : float = 5
var radius : float = 2
var pierce : int

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		body.knockback = direction * 50
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
