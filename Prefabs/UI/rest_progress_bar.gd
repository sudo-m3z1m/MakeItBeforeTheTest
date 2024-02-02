extends PlayerHud

@export var fill_duration: float

@onready var rest_progress_bar: ProgressBar = $BarConteiner/ProgressBar

func set_new_value(new_rest_level: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(rest_progress_bar, "value", new_rest_level, fill_duration)
