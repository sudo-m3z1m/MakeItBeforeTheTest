extends Panel

@export_file("*.gd") var item_path

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect

var item: Item

func _ready() -> void:
	if !item_path:
		return
	item = load(item_path).new()
	texture_rect.texture = load(item.item_image_path)

func focus_entered():
	var tween: Tween = create_tween()
	var new_alpha: Color = Color.WHITE
	new_alpha.a = 0
	tween.tween_property($MarginContainer/TextureRect, "modulate", new_alpha, 0.06)
	await tween.tween_property(self, "scale", Vector2(0.85, 0.85), 0.1)
	await tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
	
	get_tree().current_scene.apply_item(item, self)

func remove_item() -> void:
	item = null
