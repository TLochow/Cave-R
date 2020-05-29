extends RayCast2D

var collidingPos = Vector2(0.0, 0.0)
var playerPos = Vector2(0.0, 0.0)

func _process(delta):
	if is_colliding():
		var player = get_tree().get_nodes_in_group("Player")
		if player.size() != 0:
			playerPos = player[0].get_position()
		collidingPos = (get_collision_point() - playerPos).rotated(-rotation)
		$Light2D.set_position(collidingPos)
	update()

func _draw():
	draw_line(Vector2(0.0, 0.0), collidingPos, Color(1.0, 0.0, 0.0, 1.0), 1.0, true)
