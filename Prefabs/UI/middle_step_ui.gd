extends Control

@export var exam_ui_packed: PackedScene
@export var exam_week_ui_packed: PackedScene

@onready var margin_container: MarginContainer = $MarginContainer
@onready var exams_container: HBoxContainer = $ExamsContainer
@onready var texture: TextureRect = $TextureRect
@onready var week_panel: Panel = $WeekPanel
@onready var exam_week_container: HBoxContainer = $WeekPanel/MarginContainer/ExamDaysWeekContainer
@onready var today_label: Label = $WeekPanel/MarginContainer/DayWeekContainer/DayLabel

func _ready() -> void:
	Hud.set_visible_hud(Hud.rest_progress_bar, true)
	paste_week()

func play_button_pressed():
	ExamBase.rest_level += 25

func week_button_pressed() -> void:
	var new_alpha: Color = Color.WHITE
	var tween: Tween = create_tween()
	
	new_alpha.a = int(not bool(week_panel.modulate.a))
	tween.tween_property(week_panel, "modulate", new_alpha, 0.2)

func prepare_button_pressed():
	var tween: Tween = get_tree().create_tween()
	var new_alpha: Color = Color.WHITE
	
	choose_exams()
	Hud.set_visible_hud(Hud.rest_progress_bar, false)
	
	new_alpha.a = 0
	tween.tween_property(margin_container, "modulate", new_alpha, 0.1)
	
	new_alpha.a = 1
	tween.tween_property(exams_container, "modulate", new_alpha, 0.2)

func choose_exams() -> void:
	var first_exam_ui: = exam_ui_packed.instantiate()
	var second_exam_ui: = exam_ui_packed.instantiate()
	var first_exam_index: int = randi() % ExamBase.exams.size()
	
	exams_container.add_child(first_exam_ui)
	exams_container.add_child(second_exam_ui)
	
	first_exam_ui.exam = ExamBase.exams[first_exam_index]
	second_exam_ui.exam = ExamBase.exams[(first_exam_index + 1) % ExamBase.exams.size()]

func paste_week() -> void:
	var exam_day: ExamWeekUI
	
	today_label.text = str(ExamBase.current_day + 1)
	for exam in ExamBase.exams:
		exam_day = exam_week_ui_packed.instantiate()
		exam_week_container.add_child(exam_day)
		exam_day.day_label.text = str(ExamBase.exams.find(exam) + 1)
		exam_day.exam_label.text = ExamBase.exam_names[exam.exam]
		exam_day.dificulty_label.text = ExamBase.exam_dificults[int(exam.dificulty)]
		exam_day.ready_label.text = ExamBase.ready_levels[exam.ready_level]
