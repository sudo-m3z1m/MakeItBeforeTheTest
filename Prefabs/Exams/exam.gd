extends RefCounted

class_name Exam

var dificulty: float = 2
var ready_level: int
var exam: ExamBase.EXAM_BASE

func _init(ready_level: int, exam: ExamBase.EXAM_BASE) -> void:
	self.ready_level = ready_level
	self.exam = exam
	set_dificulty(exam)

func set_dificulty(exam: ExamBase.EXAM_BASE) -> void:
	match exam:
		ExamBase.EXAM_BASE.PHILOSOPHY:
			dificulty = randf_range(2.5, 2.7)
		ExamBase.EXAM_BASE.MATH:
			dificulty = randf_range(3, 4)
		ExamBase.EXAM_BASE.CHEMISTRY:
			dificulty = 4
		ExamBase.EXAM_BASE.PHYSICS:
			dificulty = randf_range(2.8, 3.2)
		ExamBase.EXAM_BASE.PHYS_TRAINING:
			dificulty = 2
		ExamBase.EXAM_BASE.INFORMATICS:
			dificulty = randf_range(2.5, 2.7)
		ExamBase.EXAM_BASE.HISTORY:
			dificulty = randf_range(2, 2.5)
