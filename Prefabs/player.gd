class_name Player
extends CharacterBody2D

@export var speed: float = 600
@export var jump_strenght: float
@export var gravity: float
@export var attack_strength: float
@export var time_distortion: float
@export var die_force_strength: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var weapon: Node2D = $Weapon
@onready var area: Area2D = $Weapon/Area2D

var time_is_slowed: bool = false
var is_died: bool = false

func _input(event):
	if event.is_action_pressed("ui_accept") and is_on_floor():
		velocity += Vector2.UP * jump_strenght / Engine.time_scale
	if event.is_action_pressed("Attack"):
		attack()
	if event.is_action_pressed("RightMouse"):
		time_is_slowed = !time_is_slowed

func _physics_process(delta):
	if !is_died:
		velocity = lerp(velocity, get_direction() * speed, 0.2)
	weapon.look_at(get_global_mouse_position())
	move_and_slide()
	velocity.y += gravity
	if !$Weapon/Area2D/CollisionShape2D.disabled:
		check_attack_objects()
	
	if time_is_slowed:
		Engine.time_scale = time_distortion
		return
	Engine.time_scale = 1

func get_direction() -> Vector2:
	var direction: Vector2
	direction.x = Input.get_axis("Left", "Right")
	return direction

func check_attack_objects() -> void:
	var area_objects: Array[Area2D] = area.get_overlapping_areas()
	for object in area_objects:
		if object is Projectile:
			object.direction = -object.direction
			$Weapon/Area2D/CollisionShape2D.disabled = true

func attack() -> void:
	var direction: Vector2 = global_position.direction_to(get_global_mouse_position())
	velocity += direction * attack_strength / Engine.time_scale
	animation_player.play("Attack")

func die() -> void:
	#animation_player.play("Death")
	is_died = true
