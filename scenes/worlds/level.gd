extends Node2D

@onready var player = $Player

func _ready():
	print(BetterTerrain._get_terrain_meta($TileMap.tile_set).terrains[0])
	print(BetterTerrain._get_terrain_meta($TileMap.tile_set).terrains[1])
	GameState.customize(player, GameState.player_data[0],
		GameState.player_data[1], GameState.player_data[2])

func _input(event):
	if Input.is_action_just_pressed("editor"):
		GameState.transition("res://scenes/editor.tscn", 1, true)
