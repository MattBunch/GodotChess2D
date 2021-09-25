extends Node2D
class_name ChessPieceBase

var color
var tile_code
var available_moves = [] setget set_available_moves, get_available_moves

func _ready():
	print("I am a base piece and I am initialized")
#	update available moves

func init(color, tile_code):
	self.color = color
	self.tile_code = tile_code
	self.set_color_sprite()
	pass
	
func set_color_sprite():
	print(self)
	print(self.color)
	match self.color:
		"white":
			get_node("BlackSprite").visible = false
		"black":
			get_node("WhiteSprite").visible = false

func move():
	# will need to call update_available_moves
	# update_available_moves()
	pass

# TODO: build out these moves
func update_available_moves():
	pass

func get_available_moves():
	pass
	
func set_available_moves(input):
	pass
