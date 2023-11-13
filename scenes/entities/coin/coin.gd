extends Node2D

var collected = false
#var sound = preload("res://scenes/entities/coin/coin.sfxr")
var current_scene = get_tree().get_current_scene()

func _ready():
	$AnimationPlayer.play("idle")

func _on_area_2d_body_entered(body):
	$AudioStreamPlayer2D.play()
	$Area2D.queue_free()
	collected = true

func _physics_process(delta):
	if !collected:
		return
	$Sprite2D.translate(Vector2.UP*5)
	$Sprite2D.modulate.a -= delta * 8


func _on_audio_stream_player_2d_finished():
	queue_free()
