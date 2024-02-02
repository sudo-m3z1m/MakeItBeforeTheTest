extends Node

class_name ExBase

var exams: Array[Exam]
var default_ready_level: int = 1
var rest_level: float = 50:
	set(new_rest_level):
		Hud.rest_progress_bar.set_new_value(new_rest_level)
		rest_level = new_rest_level

var exams_base_array: Array[EXAM_BASE] = [EXAM_BASE.PHILOSOPHY,
	EXAM_BASE.MATH,
	EXAM_BASE.CHEMISTRY,
	EXAM_BASE.PHYSICS,
	EXAM_BASE.PHYS_TRAINING,
	EXAM_BASE.INFORMATICS,
	EXAM_BASE.HISTORY]

enum EXAM_BASE {
	PHILOSOPHY,
	MATH,
	CHEMISTRY, #Science! Chemistry must be respected!
	PHYSICS,
	PHYS_TRAINING,
	INFORMATICS,
	HISTORY
}

func _ready() -> void:
	generate_week()

func generate_week() -> void:
	var new_exam: Exam
	var new_exam_type: EXAM_BASE
	for week_count in exams_base_array.size():
		new_exam_type = exams_base_array[randi() % exams_base_array.size()]
		new_exam = Exam.new(default_ready_level, new_exam_type)
		exams_base_array.erase(new_exam_type)
		exams.append(new_exam)

func is_exam_exist(exam: Exam) -> int:
	var exam_type: EXAM_BASE = exam.exam
	for ex in exams:
		if ex.exam == exam_type:
			return exams.find(ex)
	return 0

#func append_exam_to_array(new_exam: Exam) -> void:
	#if is_exam_exist(new_exam):
		#return
	#exams.append(new_exam)
#
#func set_ready_level_of_exam(exam: Exam, new_ready_level: int) -> void:
	#var exam_id: int = is_exam_exist(exam)
	#if !exam_id:
		#return
	#exams[exam_id].ready_level = new_ready_level
