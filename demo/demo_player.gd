extends Node2D

signal leave

var player: int
var input

# call this function when spawning this player to set up the input object based on the device
func init(player_num: int, device: int):
	input = DeviceInput.new(device)
	
	$Player.text = "CHAD %s" % (player_num + 1)

func _process(_delta):
	var move = input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += move
	
	# let the player leave by pressing the "join" button
	if input.is_action_just_pressed("join"):
		# an alternative to this is just call PlayerManager.leave(player)
		# but that only works if you set up the PlayerManager singleton
		leave.emit(player)
