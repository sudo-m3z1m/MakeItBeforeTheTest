extends Control

func _on_button_pressed():
	get_tree().change_scene_to_packed(preload("res://Prefabs/UI/middle_step_ui.tscn"))
