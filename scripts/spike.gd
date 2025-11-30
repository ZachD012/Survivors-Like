extends Projectile
var pierce_count: int = 0

func _ready() -> void:
	damage = 10
	pierce = 1

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and pierce_count <= pierce:
		pierce_count += 1
		body.take_damage(damage)
		if pierce_count == pierce:
			queue_free()
			
