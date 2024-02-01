class_name Player
extends CharacterBody2D

@export var speed: float = 600
@export var jump_strenght: float
@export var gravity: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _input(event):
	if event.is_action_pressed("ui_accept") and is_on_floor():
		velocity += Vector2.UP * jump_strenght / Engine.time_scale

func _physics_process(delta):
	velocity = lerp(velocity, get_direction() * speed, 0.2)
	move_and_slide()
	velocity.y += gravity

func get_direction() -> Vector2:
	var direction: Vector2
	direction.x = Input.get_axis("Left", "Right")
	return direction
