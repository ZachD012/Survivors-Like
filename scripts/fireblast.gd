extends Projectile

@onready var blast : Area2D = %Blast_Explosion
@onready var exploding_particles : GPUParticles2D = %Blast
@onready var fireball : AnimatedSprite2D = %AnimatedSprite2D
@onready var overlapping_bodies : Array[Node2D]
@onready var fire_effects : GPUParticles2D = %StaticFire

func _process(_delta) -> void:
	if blast.monitoring == true:
		var scene_tree = get_tree()
		await scene_tree.physics_frame
		await scene_tree.physics_frame
		overlapping_bodies = blast.get_overlapping_bodies()
		explode()
		blast.monitoring = false
func _on_body_entered(body: Node2D) -> void:
	blast.monitoring = true
	set_deferred("monitoring", false)
	fireball.queue_free()
	fire_effects.queue_free()

func explode():
	exploding_particles.emitting = true
	for body in overlapping_bodies:
		if body.has_method("take_damage"):
			body.take_damage(damage)


func _on_blast_finished() -> void:
	queue_free()
