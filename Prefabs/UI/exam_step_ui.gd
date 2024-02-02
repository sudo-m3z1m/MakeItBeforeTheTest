extends Control
class_name ExamStep

@export var passing_time: int
@export var start_solving_value: float
@export var max_chance: int

@onready var passing_timer: Timer = $PassingTimer
@onready var solving_progress_bar: ProgressBar = $MarginContainer/HBoxContainer/ProgressBar
@onready var timer_label: Label = $MarginContainer/TimerLabel

var exam: Exam
var solving_speed: float

func _ready() -> void:
	solving_progress_bar.value = start_solving_value
	passing_timer.start(passing_time)
	passing_timer.timeout.connect(exam_passing_time_over)
	
	exam = ExamBase.exams[0]
	solving_speed = (exam.ready_level / exam.dificulty) / 2

func _process(delta) -> void:
	timer_label.text = str(int(passing_timer.time_left))
	solving_progress_bar.value += solving_speed

func exam_passing_time_over() -> void:
	Hud.set_visible_hud(Hud.game_over_hud, true)
	get_tree().paused = true

func apply_item(used_item: Item, item_cell: Panel) -> void:
	var chance: int = randi() % max_chance
	if !used_item:
		return
	if !used_item.is_random_valid(chance):
		print(chance)
		exam_passing_time_over()
		return

	used_item.apply_item(self)
	item_cell.remove_item()
