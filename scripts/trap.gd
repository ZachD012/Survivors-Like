extends Sprite2D


@onready var trap : Sprite2D = self
var trap_ready : bool = true



func _on_trap_trigger_body_entered(body: Node2D) -> void:
	print("Body entered", str(trap_ready))
	if trap_ready:
		trap_ready = false
		var spike = load("res://scenes/spike.tscn").instantiate()
		spike.speed = 300
		spike.direction = Vector2(1.0,0).normalized()
		trap.call_deferred("add_child", spike)
	
	else:
		return
	
	print("start")
	await get_tree().create_timer(1.0).timeout
	trap_ready = true
	print("end")
