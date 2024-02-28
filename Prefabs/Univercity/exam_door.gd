extends Area3D

@export var exam_packed: PackedScene

func body_entered(body: Node3D) -> void:
	if body is Player:
		get_tree().change_scene_to_packed(exam_packed)
