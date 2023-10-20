extends Node2D

@onready var player = $Player
func nametag(): return 

var head = 0
var torso = 0
var pant = 0

func _ready():
	random()

func torso_right():
	change_torso(1)
func torso_left():
	change_torso(-1)
func change_torso(dir):
	torso = wrapi(torso+dir, 0, GameState.torsos)
	GameState.customize(player, head, torso, pant)

func head_right():
	change_head(1)
func head_left():
	change_head(-1)
func change_head(dir):
	head = wrapi(head+dir, 0, GameState.heads+GameState.hairs-1)
	GameState.customize(player, head, torso, pant)


func pants_left():
	change_pants(-1)
func pants_right():
	change_pants(1)
func change_pants(dir):
	pant = wrapi(pant+dir, 0, GameState.pants)
	GameState.customize(player, head, torso, pant)

	
func random():
	change_head(GameState.rng.randi_range(0, GameState.heads+GameState.hairs-1))
	change_torso(GameState.rng.randi_range(0, GameState.torsos))
	change_pants(GameState.rng.randi_range(0, GameState.pants))

func start():
	if GameState.players:
		GameState.players[0] = [head, torso, pant, $Control/LineEdit.get_text()]
	else:
		GameState.players.append([head, torso, pant, $Control/LineEdit.get_text()])
	get_tree().change_scene_to_file("res://scenes/worlds/level.tscn")

