extends Control

@export var run_to_exam_packed: PackedScene

@onready var prepare_button: Button = $VBoxContainer/Button
@onready var exam_title_label: Label = $VBoxContainer/Panel/MarginContainer/VBoxContainer/Title
@onready var exam_picture: TextureRect = $VBoxContainer/Panel/MarginContainer/VBoxContainer/TextureRect
@onready var dificulty_label: Label = $VBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/DificultyMount
@onready var ready_label: Label = $VBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer2/ReadyLevelMount

var exam_names: Dictionary = {
	ExamBase.EXAM_BASE.PHILOSOPHY : "Philosophy",
	ExamBase.EXAM_BASE.MATH : "Math",
	ExamBase.EXAM_BASE.CHEMISTRY : "Chemistry",
	ExamBase.EXAM_BASE.PHYSICS : "Physics",
	ExamBase.EXAM_BASE.PHYS_TRAINING : "Physical training",
	ExamBase.EXAM_BASE.INFORMATICS : "Informatics",
	ExamBase.EXAM_BASE.HISTORY : "History"
}

var exam_dificults: Dictionary = {
	2 : "Easy",
	3 : "Medium",
	4: "Hard"
}

var ready_levels: Dictionary = {
	1 : "Bad",
	2 : "Simple good", #Need to remake in future
	3: "Good"
}

var exam: Exam:
	set(new_exam):
		paste_block(new_exam)
		exam = new_exam

func paste_block(new_exam: Exam) -> void:
	exam_title_label.text = exam_names[new_exam.exam]
	set_dificulty_level_label(new_exam)
	set_ready_level_label(new_exam)

func set_dificulty_level_label(new_exam: Exam) -> void:
	dificulty_label.text = exam_dificults[int(new_exam.dificulty)]
	#colors and replace dict by match

func set_ready_level_label(new_exam: Exam) -> void:
	ready_label.text = ready_levels[int(new_exam.ready_level)]

func _on_button_pressed():
	exam.ready_level += 1
	get_tree().change_scene_to_packed(run_to_exam_packed)
