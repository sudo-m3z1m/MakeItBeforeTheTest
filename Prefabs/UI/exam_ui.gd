extends Control

@export var run_to_exam_packed: PackedScene

@onready var prepare_button: Button = $VBoxContainer/Button
@onready var exam_title_label: Label = $VBoxContainer/Panel/MarginContainer/VBoxContainer/Title
@onready var exam_picture: TextureRect = $VBoxContainer/Panel/MarginContainer/VBoxContainer/TextureRect
@onready var exam_description_label: Label = $VBoxContainer/Panel/MarginContainer/VBoxContainer/Description

var exam: Exam:
	set(new_exam):
		paste_block(new_exam)
		exam = new_exam

func paste_block(new_exam: Exam) -> void:
	exam_title_label.text = str(new_exam.exam)
	exam_description_label.text = str(new_exam.dificulty) + " " + str(new_exam.ready_level)

func _on_button_pressed():
	exam.ready_level += 1
	get_tree().change_scene_to_packed(run_to_exam_packed)
