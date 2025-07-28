extends Projectile

@onready var blast_area : Node2D = %BlastArea 

func _on_body_entered(body: Node2D) -> void:
	blast_area.set_disabled(false)
	for Enemy in get_overlapping_bodies():
		if Enemy.has_method("take_damage"):
			Enemy.take_damage(damage)
	queue_free()
