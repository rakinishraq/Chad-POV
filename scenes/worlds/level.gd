extends Node2D

@onready var player = $Player
var mouse_pos
var tile_coord

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.customize(player, GameState.player_data[0],
		GameState.player_data[1], GameState.player_data[2])


func _input(event):
	#$Camera2D/Control.visible = true;
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			BetterTerrain.set_cell($TileMap, 0, tile_coord, 0)
			BetterTerrain.update_terrain_cell($TileMap, 0, tile_coord)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			BetterTerrain.set_cell($TileMap, 0, tile_coord, -1)
			BetterTerrain.update_terrain_cell($TileMap, 0, tile_coord)
	elif event is InputEventMouseMotion:
		mouse_pos = get_global_mouse_position()
		tile_coord = $TileMap.local_to_map(mouse_pos)
		$TileMap/Highlight.position = $TileMap.map_to_local(tile_coord) - Vector2(8, 8)


func _on_button_pressed():
	Fade.crossfade_prepare(1, "Diamond", false, false)
	get_tree().change_scene_to_file("res://scenes/worlds/customize.tscn")
	Fade.crossfade_execute()
