extends Node2D
class_name BoardTile

# ?
# 	refactor Boardtile to have Area2D at base, no point in BoardTile node at the head
# 	so add this script to the Area2D object instead
#
# Each BoardTile will need a chess piece object rendered on it
# * create place_piece func, create board piece
# * create remove_piece func, remove board piece, called when piece moved or removed from board
# * create has_board_piece func, return bool of whether board_piece is taken 

#TODO: delete these variables

# !!! variables !!!
var selected = false setget set_selected, get_selected
var tile_code setget set_tile_code, get_tile_code
var selected_tile_sprite setget set_selected_tile_sprite, get_selected_tile_sprite

var move_tile_sprite setget set_move_tile_sprite, get_move_tile_sprite
var tile_has_selected_square = false setget set_tile_has_selected_square, get_tile_has_selected_square

var board_piece setget set_board_piece, get_board_piece
# NOTE: you can also get position as a setget later in the file

# signal
signal clicked_tile

func init(input_tile_code, boardColor):
	
	# Initialize colored square
	var sprite = Sprite.new()
	sprite.centered = false
	sprite.z_index = 1
	sprite.texture = load("res://Assets/White_Square_60px.png") if (boardColor) else load("res://Assets/Black_Square_60px.png")
	$Area2D.add_child(sprite)
	
	# Initialize tile code/notation
	var labelContainer = $Area2D/LabelContainer
	var debugLabel = $Area2D/LabelContainer/BoardNotation
	debugLabel.add_color_override("font_color", Color(255, 0, 0))
	set_tile_code(input_tile_code)
	debugLabel.text = get_tile_code()
	labelContainer.z_index = 2
	
	# Initialize select sprite
	var selectSprite = Sprite.new()
	selectSprite.centered = false
	selectSprite.z_index = 4
	selectSprite.texture = load("res://Assets/Selected_Square_60px.png")
	selectSprite.visible = false
	set_selected_tile_sprite(selectSprite)
	$Area2D.add_child(selected_tile_sprite)
	
	# Initialize move sprite

	var moveSprite = Sprite.new()
	moveSprite.centered = false
	moveSprite.offset.x = 16
	moveSprite.offset.y = 18
	moveSprite.z_index = 6
	moveSprite.texture = load("res://Assets/Move_Indicator_30px.png")
	moveSprite.visible = false
	set_move_tile_sprite(moveSprite)
	$Area2D.add_child(move_tile_sprite)


func place_piece(piece, board):
	$Area2D.add_child(piece)
	set_board_piece(piece)

func remove_piece(piece):
	$Area2D.remove_child(piece)
	set_board_piece(null)

func has_board_piece():
	return self.get_board_piece() != null

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		emit_signal("clicked_tile", get_tile_code())


#
#
#   _____      _   _                            _____      _   _                
#  / ____|    | | | |                  ___     / ____|    | | | |               
# | |  __  ___| |_| |_ ___ _ __ ___   ( _ )   | (___   ___| |_| |_ ___ _ __ ___ 
# | | |_ |/ _ \ __| __/ _ \ '__/ __|  / _ \/\  \___ \ / _ \ __| __/ _ \ '__/ __|
# | |__| |  __/ |_| ||  __/ |  \__ \ | (_>  <  ____) |  __/ |_| ||  __/ |  \__ \
#  \_____|\___|\__|\__\___|_|  |___/  \___/\/ |_____/ \___|\__|\__\___|_|  |___/
#
#
#

func set_board_piece(piece):
	board_piece = piece

func get_board_piece():
	return board_piece

func set_tile_code(input_tile_code):
	tile_code = input_tile_code

func get_tile_code():
	return tile_code

func get_col():
	return get_tile_code()[0]

func get_row():
	return get_tile_code()[1]

func set_tile_position(inputPos):
	position = inputPos

func get_tile_position():
	return position

func set_selected(inputSelected):
	selected = inputSelected
	if get_selected():
		show_selected_square()
	else:
		hide_selected_square()

func get_selected():
	return selected

func set_selected_tile_sprite(input):
	selected_tile_sprite = input

func get_selected_tile_sprite():
	return selected_tile_sprite

func set_move_tile_sprite(input):
	move_tile_sprite = input

func get_move_tile_sprite():
	return move_tile_sprite

func show_selected_square():
	get_selected_tile_sprite().visible = true

func hide_selected_square():
	get_selected_tile_sprite().visible = false

func show_move_sprite():
	get_move_tile_sprite().visible = true

func hide_move_sprite():
	get_move_tile_sprite().visible = false

func set_tile_has_selected_square(input):
	tile_has_selected_square = input

func get_tile_has_selected_square():
	return tile_has_selected_square
