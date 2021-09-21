extends Node2D
class_name ChessPieceBase

var player
var tile_code
var first_move = true
var availalbe_moves = []

func _ready():
	print("I am a base piece and I am initialized")
#	update available moves

func move():
	# will need to call update_available_moves
	# update_available_moves()
	pass

func update_available_moves():
	pass
