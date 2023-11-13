extends Node2D

var mouse_pos = Vector2.ZERO
var mouse_pos_prev = Vector2.ZERO
var mouse_vel = Vector2.ZERO

var tile_coord = Vector2i.ZERO
var tile_coord_prev = Vector2i.ZERO

var left_pressed = false
var right_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if mouse_pos != mouse_pos_prev:
			$Camera2D.position += -mouse_vel * delta * 60

func _input(event):
	if left_pressed and tile_coord != tile_coord_prev:
		BetterTerrain.set_cell($TileMap, 0, tile_coord, 0)
		BetterTerrain.update_terrain_cell($TileMap, 0, tile_coord)
		tile_coord_prev = tile_coord
	
	if Input.is_action_just_pressed("editor"):
		GameState.transition("res://scenes/worlds/level.tscn", 1)

	if event is InputEventMouseMotion:
		mouse_vel = get_global_mouse_position() - mouse_pos_prev
		mouse_pos = get_global_mouse_position()
		mouse_pos_prev = mouse_pos

		tile_coord = $TileMap.local_to_map(mouse_pos)
		$Highlight.position = $TileMap.map_to_local(tile_coord) - Vector2(8, 8)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			right_pressed = event.is_pressed()
			if right_pressed:
				BetterTerrain.set_cell($TileMap, 0, tile_coord, -1)
				BetterTerrain.update_terrain_cell($TileMap, 0, tile_coord)
		
	


func _on_highlight_pressed():
	left_pressed = true
func _on_highlight_released():
	left_pressed= false