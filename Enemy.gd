extends KinematicBody2D

signal GameOver

var nav = null
var path = []
var Active = false

var SPEED = 40.0

var end = false

func _ready():
	$Scream.play()
	$FootstepTimer/AudioStreamPlayer.play()

func _process(delta):
	if Active:
		if path.size() > 1:
			var d = get_position().distance_to(path[0])
			if d >= SPEED * delta:
				var nextGoal = path[0]
				var speed = (SPEED * delta) / d
				set_position(get_position().linear_interpolate(nextGoal, speed))
			else:
				update_path()

func Activate():
	Active = true
	$Scream.play()
	$Light2D/Tween.interpolate_property($Light2D, "energy", 0.0, 2.0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Light2D/Tween.start()
	$FootstepTimer.start()
	Global.CameraShake = 8.0
	update_path()

func _on_Scream_finished():
	$Scream.volume_db = 0.0

func update_path():
	var player = get_tree().get_nodes_in_group("Player")
	if player.size() != 0:
		path = nav.get_simple_path(get_position(), player[0].get_position(), false)
		while path.size() > 0 and get_position().distance_to(path[0]) <= 2:
			path.remove(0)

func _on_Range_body_entered(body):
	if Active:
		if not end:
			end = true
			EndScream.Play()
			emit_signal("GameOver")
	
func _on_FootstepTimer_timeout():
	$FootstepTimer/AudioStreamPlayer.play()
	Global.CameraShake += 4.0

func _on_AudioStreamPlayer_finished():
	$FootstepTimer/AudioStreamPlayer.volume_db = 0.0
