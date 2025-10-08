extends Control


func _ready() -> void:
	hide()

func _on_retry_pressed() -> void:
	hide()
	get_tree().call_group("Player", "reset")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	get_tree().quit()
