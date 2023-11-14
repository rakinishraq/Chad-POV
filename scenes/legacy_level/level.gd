extends Node2D

@onready var player = $Player

func _ready():
	GameState.customize(player, GameState.player_data[0],
		GameState.player_data[1], GameState.player_data[2])

func _input(event):
	if Input.is_action_just_pressed("editor"):
		GameState.transition(GameState.editor_path, 1, true)
