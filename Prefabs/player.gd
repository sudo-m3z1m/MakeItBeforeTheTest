class_name Player
extends CharacterBody3D

@onready var camera: Camera3D = $Camera3D
@onready var visible_sphere = $Camera3D/VisibleSphere
@onready var raycast: RayCast3D = $Camera3D/RayCast3D

@export var speed: float
@export var jump_strenght: float
@export var gravity: float
@export var front_wall_z: float

func _input(event):
	if event.is_action_pressed("ui_accept") and is_on_floor():
		velocity += Vector3.UP * jump_strenght

func _physics_process(delta):
	camera.global_position.z = 5
	raycast.target_position.z = (global_position - camera.global_position).z
	
	velocity.x = lerp(velocity.x, get_direction().x * speed, 0.2)
	velocity.z = lerp(velocity.z, get_direction().z * speed, 0.2)
	move_and_slide()
	velocity.y -= gravity
	global_position.z = clamp(global_position.z, -10, front_wall_z)
	check_walls()

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

func change_camera_posiiton(new_position: Vector3, duration: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(camera, "global_position", new_position, duration)

func check_walls() -> void:
	var tween: Tween = create_tween()
	var sphere_radius: float = 1.1
	if raycast.get_collider() is Player:
		tween.tween_property(visible_sphere, "radius", sphere_radius / 10, 0.1)
		return
	tween.tween_property(visible_sphere, "radius", sphere_radius, 0.1)
