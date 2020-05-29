extends KinematicBody2D

var Motion = Vector2(0.0, 0.0)

var LaserRotation = 0.0

func _physics_process(delta):
	Motion.y += 10.0
	
	var xMove = 0.0
	if Input.is_action_pressed("ui_left"):
		xMove += -100.0
	if Input.is_action_pressed("ui_right"):
		xMove += 100.0
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			Motion.y = -300.0
	
	Motion.x = xMove
	var potentialParticles = Motion.y >= 100.0
	Motion = move_and_slide(Motion, Vector2(0.0, -1.0))
	var moving = false
	if Motion.x < 0.0:
		$Sprite.flip_h = true
		moving = true
	elif Motion.x > 0.0:
		$Sprite.flip_h = false
		moving = true
	
	if moving:
		SwitchAnimation($AnimationPlayer, "Walk")
	else:
		SwitchAnimation($AnimationPlayer, "Stand")
	
	Global.CameraShake = max(Global.CameraShake - (delta * 3.0), 0.0)
	$Camera2D.offset = Vector2(0.0, 0.0)
	if Global.CameraShake > 0.0:
		$Camera2D.offset.x += rand_range(-Global.CameraShake, Global.CameraShake)
		$Camera2D.offset.y += rand_range(-Global.CameraShake, Global.CameraShake)
	
	HandleLasers(delta)

func HandleLasers(delta):
	$Lasers/Group.set_position(get_position())
	
	LaserRotation += 2.0 * delta
	while LaserRotation > TAU:
		LaserRotation -= TAU
	
	var lasers = $Lasers/Group.get_children()
	var count = 0.0
	var maxRotate = (TAU - (TAU / 6.0))
	for laser in lasers:
		count += 1.0
		laser.rotation = LaserRotation + Global.map(count, 1.0, 6.0, 0.0, maxRotate)

func SwitchAnimation(animationPlayer, animation):
	if animationPlayer.current_animation != animation:
		animationPlayer.play(animation)
		
