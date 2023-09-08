extends Node2D

var rng = RandomNumberGenerator.new()

var heads
var torsos
var hairs
var pants

var head = 0
var torso = 0
var pant = 0

var head_base
var head_hair
var visible_hair
var visible_brows

func _ready():
	rng.randomize()
	
	heads = $Player/ROOT/HEADS.sprite_frames.get_frame_count("default")
	torsos = $Player/ROOT/TORSOS.sprite_frames.get_frame_count("default")
	hairs = $Player/ROOT/HAIRS.sprite_frames.get_frame_count("default")
	pants = GameState.pant_colors.size()
	
	random()


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
	head = wrapi(head+dir, 0, heads+hairs-1)
	head_base = min(head, heads-1)
	$Player/ROOT/HEADS.set_frame(head_base)
	head_hair = head-heads+1
	$Player/ROOT/BROWS.modulate = GameState.hair_colors[head_hair]
	$Player/ROOT/HAIRS.set_frame(head_hair)
	visible_hair = head >= heads - 1
	$Player/ROOT/HAIRS.visible = visible_hair
	visible_brows = head_base == heads - 1
	$Player/ROOT/BROWS.visible = visible_brows


func pants_left():
	change_pants(-1)
func pants_right():
	change_pants(1)
func change_pants(dir):
	pant = wrapi(pant+dir, 0, pants)
	$Player/ROOT/IDLE.modulate = GameState.pant_colors[pant]
	$Player/ROOT/MOVE.modulate = GameState.pant_colors[pant]

	
func random():
	change_head(rng.randi_range(0, heads+hairs-1))
	change_torso(rng.randi_range(0, torsos))
	change_pants(rng.randi_range(0, pants))

func start():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
