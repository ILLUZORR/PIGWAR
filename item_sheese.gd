extends Node2D




func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$use.play()
		await $use.finished
		$"../level_temp/Player".SPEED = 600.0
		body.scale.y = 0.5
		body.health = 1
		queue_free()
