extends CharacterBody2D

@onready var player = get_node("/root/Main/PlayerHuman")
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

const SPEED = 38.0
	
func _ready():
	animation_tree.active = true
	state_machine.start("Idle")  # optional, ensures a valid start state

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	move_and_slide()

	# Decide which animation to play
	if velocity.length() > 0:
		state_machine.travel("Walk")
		# If using blend_space (side/up/down walking)
		animation_tree.set("parameters/Walk/blend_position", direction)
	else:
		state_machine.travel("Idle")
