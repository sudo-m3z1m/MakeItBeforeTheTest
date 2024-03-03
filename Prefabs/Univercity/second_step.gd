extends Node3D

@export_category("University")
@export var exam_door_packed: PackedScene
@export var crowd_scenes_packed: Array[PackedScene]

@onready var door_positions: Array[Node] = $DoorsMarkers.get_children()
#@onready var crowd_positions: Array[Node] = $CrowdMarkers.get_children()

func _ready() -> void:
	var exam_door_pos: Vector3
	
	exam_door_pos = choose_exam_door_pos()
	spawn_door(exam_door_pos)

func choose_exam_door_pos() -> Vector3:
	var new_door_spawn_pos: Vector3 = Vector3.ZERO
	var door_marker: Marker3D
	
	door_marker = door_positions[randi() % door_positions.size()]
	new_door_spawn_pos = door_marker.global_position
	
	return new_door_spawn_pos

func spawn_door(door_pos: Vector3) -> void:
	var exam_door: ExamDoor
	
	exam_door = exam_door_packed.instantiate()
	add_child(exam_door)
	exam_door.global_position = door_pos
