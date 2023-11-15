extends Node2D


func _ready():
	var root = GameState.load_level("Tileset Test")
	var player = root.get_node("Player")
	$Player.position = player.position
	$Player.spawn = player.position
	$Player/Camera2D.enabled = true
	player.queue_free()


func _input(_event):
	if Input.is_action_just_pressed("editor"):
		GameState.transition(GameState.editor_path, 1, true)


func _on_BGM_finished():
	$BGM.play()
