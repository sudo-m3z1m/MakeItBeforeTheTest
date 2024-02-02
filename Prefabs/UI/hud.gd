extends CanvasLayer

@onready var game_over_hud: Panel = $MarginContainer/GameOverHUD
@onready var rest_progress_bar: Control = $MarginContainer/RestProgressBar

func set_visible_hud(hud: Control, is_visible: bool) -> void:
	var new_alpha: Color = Color.WHITE
	var tween: Tween = create_tween()
	
	new_alpha.a = int(is_visible)
	
	hud.set_enabled(is_visible)
	tween.tween_property(hud, "modulate", new_alpha, 0.1)
