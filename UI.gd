extends Control

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$StartRect/Tween.interpolate_property($StartRect, "color", Color(0.0, 0.0, 0.0, 0.0), Color(0.0, 0.0, 0.0, 1.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$StartRect/Tween.start()
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_Tween_tween_all_completed():
	get_tree().change_scene("res://Main.tscn")
