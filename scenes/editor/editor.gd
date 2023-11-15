extends Node2D

var mouse_pos = Vector2.ZERO
var mouse_pos_prev = Vector2.ZERO
var mouse_vel = Vector2.ZERO

var tile_coord = Vector2i.ZERO
var tile_coord_prev = Vector2i.ZERO

var left_pressed = false;

var root;
@onready var gui = $Camera2D/CanvasLayer/EditorGUI

func _ready():
	root = GameState.load_level(self, "Tileset Test")

	for i in range(BetterTerrain.terrain_count(root.tile_set)):
		var icon = BetterTerrain.get_terrain(root.tile_set, i).icon
		gui.add_button(
			root.tile_set.get_source(icon["source_id"]).texture,
			icon["coord"])


func _input(event):
	# play level
	if Input.is_action_just_pressed("editor"):
		GameState.transition(GameState.level_path, 1)
	
	# place and update if new tile
	if left_pressed and tile_coord != tile_coord_prev:
		BetterTerrain.set_cell(root, 1, tile_coord, gui.tile_index)
		BetterTerrain.update_terrain_cell(root, 1, tile_coord)
		tile_coord_prev = tile_coord
	
	# update highlight position
	if event is InputEventMouseMotion:
		mouse_vel = get_global_mouse_position() - mouse_pos_prev
		mouse_pos = get_global_mouse_position()
		mouse_pos_prev = mouse_pos

		tile_coord = root.local_to_map(mouse_pos)
		$Highlight.position = root.map_to_local(tile_coord) - Vector2(8, 8)
		
	
# using button for left-click due to buggy _unhandled_input
func _on_highlight_pressed():
	left_pressed = true
func _on_highlight_released():
	left_pressed= false

