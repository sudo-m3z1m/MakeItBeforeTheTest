extends Node3D

@onready var area: Area3D = $CrowdArea

@export_category("Crowd properties")
@export_range(0, 1) var speed_decrease_multiplier: float

func _ready() -> void:
	area.body_entered.connect(on_player_entered)
	area.body_exited.connect(on_player_exited)

func on_player_entered(player: Node3D) -> void:
	if !(player is Player):
		return
	player.speed *= speed_decrease_multiplier

func on_player_exited(player: Node3D) -> void:
	if !(player is Player):
		return
	player.speed /= speed_decrease_multiplier
