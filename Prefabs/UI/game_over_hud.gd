extends PlayerHud

func try_again_button_pressed():
	get_tree().paused = false
	Hud.set_visible_hud(self, false)

func exit_button_pressed():
	get_tree().quit()

func set_enabled(is_enabled: bool) -> void:
	$MarginContainer/VBoxContainer/HBoxContainer/TryAgainButton.disabled = !is_enabled
	$MarginContainer/VBoxContainer/HBoxContainer/ExitButton.disabled = !is_enabled
