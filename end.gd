extends Node2D

@onready var anim = $AnimatedSprite2D



func _on_button_pressed():
	anim.play("End")
	get_tree().change_scene_to_file("res://menu.tscn")
