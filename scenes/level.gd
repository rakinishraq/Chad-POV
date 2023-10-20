extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.customize(player, GameState.players[0][0],
		GameState.players[0][1], GameState.players[0][2], GameState.players[0][3])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/customize.tscn")
