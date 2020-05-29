extends Node2D

func _ready():
	Play()

func Play():
	$AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.volume_db = 0.0
