extends Node

var rng = RandomNumberGenerator.new()

var pant_colors = [Color("#19181e"), Color("#2e2445"), Color("#453239"), Color("#493733"), Color("#362a38")]
var hair_colors = [Color("#243841"), Color("#19181e"), Color("#c2862f"), Color("#4e3634"), Color("#a04133"), Color("#333641"), Color("#4d3634")]

var heads
var torsos
var hairs
var pants

var player_data = []

func _ready():
	rng.randomize()
	heads = load("res://scenes/entities/player/sprites/heads/heads.tscn").instantiate().sprite_frames.get_frame_count("default")
	torsos = load("res://scenes/entities/player/sprites/torsos/torsos.tscn").instantiate().sprite_frames.get_frame_count("default")
	hairs = load("res://scenes/entities/player/sprites/hair/hairs.tscn").instantiate().sprite_frames.get_frame_count("default")
	pants = GameState.pant_colors.size()

func customize(player, head, torso, pant, nametag=""):
	var head_base = min(head, heads-1)
	var player_canvas = player.get_node("ROOT/CanvasGroup")
	player_canvas.get_node("HEADS").set_frame(head_base)
	var head_hair = head-GameState.heads+1
	player.get_node("ROOT/BROWS").modulate = GameState.hair_colors[head_hair]
	player_canvas.get_node("HAIRS").set_frame(head_hair)
	var visible_hair = head >= GameState.heads - 1
	player_canvas.get_node("HAIRS").visible = visible_hair
	var visible_brows = head_base == GameState.heads - 1
	player.get_node("ROOT/BROWS").visible = visible_brows
	
	player_canvas.get_node("TORSOS").set_frame(torso)
	
	player_canvas.get_node("IDLE").modulate = GameState.pant_colors[pant]
	player_canvas.get_node("MOVE").modulate = GameState.pant_colors[pant]
	
	player.get_node("NameTag").text = nametag
