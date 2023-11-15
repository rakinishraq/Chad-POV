extends Control

@onready var container = $Hotbar/MarginContainer/HBoxContainer
@onready var button = container.get_child(0)
@onready var group = button.button_group
var tile_index = -1

func add_button(texture, region):
	var atlas = AtlasTexture.new()
	atlas.atlas = texture
	atlas.region = Rect2i(region.x * 16, region.y * 16, 16, 16)

	var new = button.duplicate()
	new.button_pressed = false
	var texture_rect = new.get_node("MarginContainer/TextureRect")
	texture_rect.texture = atlas
	container.add_child(new)


func _on_hotbar_pressed():
	tile_index = group.get_buttons().find(group.get_pressed_button()) - 1

func _input(event):
	var buttons = group.get_buttons()
	if event is InputEventKey and event.pressed:
		for i in range(1, 11):
			if Input.is_key_pressed(i + KEY_0 - 1):
				var pressed = 10 if i == 1 else i - 1
				if pressed <= buttons.size():
					tile_index = pressed - 2
					buttons[tile_index + 1].button_pressed = true
				break
