extends Area2D
class_name Projectile

@export var speed: float
@export var direction: int

func _ready() -> void:
	body_entered.connect(body_is_damagable)

func _process(delta) -> void:
	var direction: Vector2 = Vector2(direction, 0)
	var velocity = direction * speed * delta
	
	global_position += velocity

func body_is_damagable(body) -> void:
	if body is Player:
		body.die()
	queue_free()
