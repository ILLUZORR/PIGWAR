extends Node2D


func _on_yes_pressed():
	get_tree().change_scene_to_file("res://levels_menu.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
