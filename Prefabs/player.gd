class_name Player
extends CharacterBody3D

@export var speed: float
@export var jump_strenght: float
@export var gravity: float
@export var front_wall_z: float

func _input(event):
	if event.is_action_pressed("ui_accept") and is_on_floor():
		velocity += Vector3.UP * jump_strenght

func _physics_process(delta):
	velocity.x = lerp(velocity.x, get_direction().x * speed, 0.2)
	velocity.z = lerp(velocity.z, get_direction().z * speed, 0.2)
	move_and_slide()
	velocity.y -= gravity
	global_position.z = clamp(global_position.z, -10, front_wall_z)

func get_direction() -> Vector3:
	var direction: Vector3
	direction.x = Input.get_axis("Left", "Right")
	direction.z = Input.get_axis("Up", "Down")
	direction = direction.normalized()
	return direction

func area_entered(area: Node3D) -> void:
	if area is ItemPickable:
		ExamBase.add_item(area.item)
	area.queue_free()
