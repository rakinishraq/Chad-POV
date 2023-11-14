extends Node2D


func _input(_event):
	if Input.is_action_just_pressed("editor"):
		GameState.transition(GameState.editor_path, 1, true)


func _on_BGM_finished():
	$BGM.play()