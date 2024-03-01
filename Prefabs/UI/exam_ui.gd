extends Control

@export var run_to_exam_packed: PackedScene

@onready var prepare_button: Button = $VBoxContainer/Button
@onready var exam_title_label: Label = $VBoxContainer/Panel/MarginContainer/VBoxContainer/Title
@onready var exam_picture: TextureRect = $VBoxContainer/Panel/MarginContainer/VBoxContainer/TextureRect
@onready var dificulty_label: Label = $VBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/DificultyMount
@onready var ready_label: Label = $VBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer2/ReadyLevelMount

var exam: Exam:
	set(new_exam):
		paste_block(new_exam)
		exam = new_exam

func paste_block(new_exam: Exam) -> void:
	exam_title_label.text = ExamBase.exam_names[new_exam.exam]
	set_dificulty_level_label(new_exam)
	set_ready_level_label(new_exam)

func set_dificulty_level_label(new_exam: Exam) -> void:
	dificulty_label.text = ExamBase.exam_dificults[int(new_exam.dificulty)]
	#colors and replace dict by match

func set_ready_level_label(new_exam: Exam) -> void:
	ready_label.text = ExamBase.ready_levels[int(new_exam.ready_level)]

func _on_button_pressed():
	exam.ready_level += 1
	get_tree().change_scene_to_packed(run_to_exam_packed)
