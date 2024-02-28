extends Control

@export var exam_ui_packed: PackedScene

@onready var margin_container: MarginContainer = $MarginContainer
@onready var exams_container: HBoxContainer = $ExamsContainer
@onready var texture: TextureRect = $TextureRect

func _ready() -> void:
	Hud.set_visible_hud(Hud.rest_progress_bar, true)

func play_button_pressed():
	ExamBase.rest_level += 25

func prepare_button_pressed():
	var first_exam_ui: = exam_ui_packed.instantiate()
	var second_exam_ui: = exam_ui_packed.instantiate()
	var tween: Tween = get_tree().create_tween()
	var new_alpha: Color = Color.WHITE
	
	Hud.set_visible_hud(Hud.rest_progress_bar, false)
	
	exams_container.add_child(first_exam_ui)
	exams_container.add_child(second_exam_ui)
	
	first_exam_ui.exam = ExamBase.exams[randi() % ExamBase.exams.size()]
	second_exam_ui.exam = ExamBase.exams[randi() % ExamBase.exams.size()]
	
	new_alpha.a = 0
	tween.tween_property(margin_container, "modulate", new_alpha, 0.1)
	
	new_alpha.a = 1
	tween.tween_property(exams_container, "modulate", new_alpha, 0.2)
