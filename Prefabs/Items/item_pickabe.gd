extends Area3D
class_name ItemPickable

@export_file("*.gd") var item_path

@onready var sprite: Sprite3D = $Sprite3D

var item: Item

func _ready() -> void:
	item = load(item_path).new()
	sprite.texture = load(item.item_image_path)
