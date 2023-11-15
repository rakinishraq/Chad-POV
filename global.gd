extends Node

# Player System
var rng = RandomNumberGenerator.new()
var outline_size = 1

var pant_colors = [Color("#19181e"), Color("#2e2445"), Color("#453239"), Color("#493733"), Color("#362a38")]
var hair_colors = [Color("#243841"), Color("#19181e"), Color("#c2862f"), Color("#4e3634"), Color("#a04133"), Color("#333641"), Color("#4d3634")]

var heads
var torsos
var hairs
var pants

var player_data = []
var release = OS.has_feature("standalone")


func _ready():
	rng.randomize()
	heads = load("res://scenes/entities/player/sprites/heads/heads.tscn").instantiate().sprite_frames.get_frame_count("default")
	torsos = load("res://scenes/entities/player/sprites/torsos/torsos.tscn").instantiate().sprite_frames.get_frame_count("default")
	hairs = load("res://scenes/entities/player/sprites/hair/hairs.tscn").instantiate().sprite_frames.get_frame_count("default")
	pants = GameState.pant_colors.size()

	outline_size = min(
		5.05 / 1890 * DisplayServer.window_get_size().x,
		5.05 / 1080 * DisplayServer.window_get_size().y)


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


# Level System
var level_path = "res://scenes/levels/level_host.tscn"
var editor_path = "res://scenes/editor/editor.tscn"
var sel_level = "Tileset Test"

func transition(path, time=1, reverse=false, pattern="Diamond"):
	Fade.crossfade_prepare(time, pattern, reverse, false)
	get_tree().change_scene_to_file(path)
	Fade.crossfade_execute()


func load_level(parent, level_name=sel_level):
	sel_level = level_name
	const path = "res://scenes/levels/"
	print(path+level_name+"/tile_map.tscn")
	var root = load(path+level_name+"/tile_map.tscn").instantiate()
	parent.add_child(root)
	return root