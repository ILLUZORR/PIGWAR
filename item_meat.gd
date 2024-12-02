extends Node2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$use.play()
		await $use.finished
		body.health += 25
		body.scale.x += 1
		body.scale.y += 1
		queue_free()
