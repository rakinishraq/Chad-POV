extends Node2D

var collected = false
var sound = preload("coin.sfxr")

func _ready():
	pass


func _on_area_2d_body_entered(body):
	$AudioStreamPlayer2D.play()
	$Area2D/CollisionShape2D.disabled = true
	collected = true

func _physics_process(delta):
	if !collected:
		return
	$Sprite2D.translate(Vector2.UP*5)
	$Sprite2D.modulate.a -= delta * 8
	if $Sprite2D.modulate.a <= 0.1:
		queue_free()
