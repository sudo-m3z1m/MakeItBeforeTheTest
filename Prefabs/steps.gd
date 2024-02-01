extends StaticBody2D

@onready var steps_area: Area2D = $Area2D
@onready var collision: CollisionShape2D = $Collision

func _ready() -> void:
	steps_area.body_entered.connect(enable_steps)

func enable_steps(body) -> void:
	collision.set_deferred("disabled", !collision.disabled)
