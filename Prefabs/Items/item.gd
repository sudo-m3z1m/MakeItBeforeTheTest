extends RefCounted
class_name Item

var item_image_path: String
var chance_of_losing: int
var solving_boost: float

func is_random_valid(random_value: int) -> bool:
	return random_value >= chance_of_losing

func apply_item(exam_scene: ExamStep) -> void:
	exam_scene.solving_progress_bar.value += solving_boost
	#Animations
