extends Node2D




func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$use.play()
		body.health += 60
		queue_free()
