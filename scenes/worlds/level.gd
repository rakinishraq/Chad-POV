extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.customize(player, GameState.player_data[0],
		GameState.player_data[1], GameState.player_data[2])
	#$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/worlds/customize.tscn")
