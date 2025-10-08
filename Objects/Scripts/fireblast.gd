extends Projectile

@onready var blast: Area2D = %Blast_Explosion
@onready var exploding_particles: GPUParticles2D = %Blast
@onready var fireball: AnimatedSprite2D = %AnimatedSprite2D
@onready var fire_effects: GPUParticles2D = %StaticFire

var has_exploded := false

func _ready():
	blast.monitoring = false
	blast.monitorable = true
	blast.body_entered.connect(_on_body_entered)
	blast.area_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	if has_exploded:
		return

	has_exploded = true

	# Hide projectile visuals
	fireball.queue_free()
	fire_effects.queue_free()

	# Activate blast area
	blast.set_deferred("monitoring", true)
	exploding_particles.emitting = true

	# Wait a couple of physics frames before checking overlaps
	call_deferred("_process_explosion")

func _process_explosion():
	await get_tree().physics_frame
	await get_tree().physics_frame

	var overlapping_bodies = blast.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.has_method("take_damage"):
			body.take_damage(damage)

	blast.set_deferred("monitoring", false)

func _on_blast_finished():
	queue_free()





#@onready var blast : Area2D = %Blast_Explosion
#@onready var exploding_particles : GPUParticles2D = %Blast
#@onready var fireball : AnimatedSprite2D = %AnimatedSprite2D
#@onready var overlapping_bodies : Array[Node2D]
#@onready var fire_effects : GPUParticles2D = %StaticFire
#
#func _process(_delta) -> void:
	#if blast.monitoring == true:
		#var scene_tree = get_tree()
		#await scene_tree.physics_frame
		#await scene_tree.physics_frame
		#overlapping_bodies = blast.get_overlapping_bodies()
		#explode()
		#blast.set_deferred("monitoring", false)
#
#func _on_body_entered(body: Node2D) -> void:
	#blast.monitoring = true
	#set_deferred("monitoring", false)
	#fireball.queue_free()
	#fire_effects.queue_free()
#
#func explode():
	#exploding_particles.emitting = true
	#for body in overlapping_bodies:
		#if body.has_method("take_damage"):
			#body.take_damage(damage)
#
#
#func _on_blast_finished() -> void:
	#queue_free()
