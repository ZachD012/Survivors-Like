extends Label

func _ready() -> void:
	pop()

func pop():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0.7,0.7), 0.8)
	tween.chain().tween_property(self, "scale", Vector2(0.5,0.5), 0.8) #tween the scale from 1 to 2 then 2 to 1 by chaining
	await tween.finished
	queue_free()
