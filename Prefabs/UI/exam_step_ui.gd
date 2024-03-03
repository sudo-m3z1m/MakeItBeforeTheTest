extends Control
class_name ExamStep

@export var passing_time: int
@export var start_solving_value: float
@export var max_chance: int
@export_file() var prepare_scene_packed

@onready var passing_timer: Timer = $PassingTimer
@onready var solving_progress_bar: ProgressBar = $MarginContainer/HBoxContainer/ProgressBar
@onready var timer_label: Label = $MarginContainer/TimerLabel

@onready var cells_array: Array[Panel] = [$MarginContainer/HBoxContainer2/ItemCell,
$MarginContainer/HBoxContainer2/ItemCell2,
$MarginContainer/HBoxContainer2/ItemCell3]

var exam: Exam
var solving_speed: float

func _ready() -> void:
	solving_progress_bar.value = start_solving_value
	passing_timer.start(passing_time)
	passing_timer.timeout.connect(exam_passing_time_over)
	
	exam = ExamBase.exams[ExamBase.current_day]
	solving_speed = (exam.ready_level / exam.dificulty) / 2
	paste_items_to_cells()

func _process(delta) -> void:
	timer_label.text = str(int(passing_timer.time_left))
	solving_progress_bar.value += solving_speed

func exam_passing_time_over() -> void:
	Hud.set_visible_hud(Hud.game_over_hud, true)
	get_tree().paused = true

func paste_items_to_cells() -> void:
	for item in ExamBase.collected_items.size():
		cells_array[item].item = ExamBase.collected_items[item]
		cells_array[item].update_cell()
	ExamBase.collected_items.clear()

func apply_item(used_item: Item, item_cell: Panel) -> void:
	var chance: int = randi() % max_chance
	if !used_item:
		return
	if !used_item.is_random_valid(chance):
		exam_passing_time_over()
		return
	
	grab_focus()
	
	used_item.apply_item(self)
	item_cell.remove_item()

func bar_value_changed(value):
	if value == solving_progress_bar.max_value:
		ExamBase.current_day += 1
		get_tree().change_scene_to_packed(load(prepare_scene_packed))
