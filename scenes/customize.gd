extends Node2D

var heads
var torsos
var hairs

var head = 0
var torso = 0

var head_base
var head_hair
var visible_hair
var visible_brows

func _ready():
	heads = $Player/ROOT/HEADS.sprite_frames.get_frame_count("default")
	torsos = $Player/ROOT/TORSOS.sprite_frames.get_frame_count("default")
	hairs = $Player/ROOT/HAIRS.sprite_frames.get_frame_count("default")
	change_head(heads)


func torso_right():
	change_torso(1)
func torso_left():
	change_torso(-1)
func change_torso(dir):
	torso = wrapi(torso+dir, 0, torsos)
	$Player/ROOT/TORSOS.set_frame(torso)

func head_right():
	change_head(1)
func head_left():
	change_head(-1)
func change_head(dir):
	head = wrapi(head+dir, 0, heads+hairs)
	head_base = min(head, heads-1)
	$Player/ROOT/HEADS.set_frame(min(head, heads-1))
	head_hair = head-heads
	$Player/ROOT/HAIRS.set_frame(head-heads)
	visible_hair = head > 3
	$Player/ROOT/HAIRS.visible = visible_hair
	visible_brows = head_base == heads - 1
	$Player/ROOT/BROWS.visible = visible_brows


func start():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
