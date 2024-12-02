extends Node2D

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://level.tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://level_2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://level_3.tscn")


func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://level_4.tscn")


func _on_level_5_pressed():
	get_tree().change_scene_to_file("res://level_5.tscn")



func _on_level_6_pressed():
	get_tree().change_scene_to_file("res://level_6.tscn")
