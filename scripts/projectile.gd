extends Area2D
class_name Projectile

var travelled_distance = 0

var direction : Vector2 = Vector2.RIGHT
var speed : float
var damage : float
var pierce : int

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _ready():
	connect("body_entered", Callable(self, "on_body_entered"))

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
