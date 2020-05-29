extends Node2D

var PlayedFarScream = false
var EnemyActive = false

var GameOver = false

func _ready():
	$FarScream/AudioStreamPlayer.play()
	$Enemy.nav = $Navigation2D
	$Enemy.connect("GameOver", self, "GameOver")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_FarScream_body_entered(body):
	if not PlayedFarScream:
		PlayedFarScream = true
		$FarScream/AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	$FarScream/AudioStreamPlayer.volume_db = 0.0

func _on_EnemyActivate_body_entered(body):
	if not EnemyActive:
		EnemyActive = true
		$Enemy.Activate()
		$Chase.play()
		$Creepy.stop()

func GameOver():
	GameOver = true
	$UI/Tween.interpolate_property($UI/ColorRect, "color", Color(1.0, 0.0, 0.0, 0.0), Color(1.0, 0.0, 0.0, 1.0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$UI/Tween.start()

func _on_Tween_tween_all_completed():
	if GameOver:
		get_tree().change_scene("res://GameOver.tscn")
	else:
		get_tree().change_scene("res://Win.tscn")

func _on_WinArea_body_entered(body):
	GameOver = false
	$UI/Tween.interpolate_property($UI/ColorRect, "color", Color(1.0, 1.0, 1.0, 0.0), Color(1.0, 1.0, 1.0, 1.0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$UI/Tween.start()
