extends Node2D
class_name Game

const BOARD_SIZE = 480

# array to hold all tiles
# can't use onready because board has to be initialized first
onready var tiles = initialize_board()

# tile that user clicks on
var saved_tile

# turn system
var turn = "white"
var turn_count = 1

func clicked_tile(tile_code):
	# TODO: change these tiles' commands into individual functions 
	# eg:
		# process move

	var tile = get_tile_at_code(tile_code)

	if saved_tile == tile:
		print("same tile: ", saved_tile.get_tile_code())
		unselect_tile()

	elif saved_tile == null:
		select_tile(tile)
		print("tile saved: ", saved_tile.get_tile_code())
		# TODO: if tile has piece, show piece's available moves here:
		

	else:
		print("tile: ",tile.get_tile_code())
		print("saved_tile: ",saved_tile.get_tile_code())
		# TODO: process moves between the two tiles here
		# if tile is empty that the selected tile can't move to or tile contains piece of the same color, 
		# select the new targeted tile
		unselect_tile()
		select_tile(tile)
		# elif target tile is place the piece can move to (empty or contains enemy), process move
		# move_piece()
		# TODO: function also needs to log move in movements
		# log_move(tile, saved_tile)
		# TODO: progress turn
		# next_turn()

func select_tile(tile):
	saved_tile = tile
	saved_tile.set_selected(true)
	print(saved_tile.has_board_piece())

func unselect_tile():
	saved_tile.set_selected(false)
	saved_tile = null

# REFACTOR: possibly delete this func since I am now moving to code based selection of tiles
func get_tile_at_pos(pos):
	for tile in tiles:
		if tile != null:
			if tile.get_position() == pos:
				return tile
	
	return null

func get_tile_at_code(code):
	for tile in tiles:
		if tile != null:
			if tile.get_tile_code() == code:
				return tile
	
	return null

func initialize_board():
	var A = 65
	var startNum = 8
	var white = true
	var output = []
	var numCounter = startNum
	var charCounter = A
	for x in range(0, BOARD_SIZE, BOARD_SIZE / 8):
		numCounter = startNum
		white = !white
		for y in range(0, BOARD_SIZE, BOARD_SIZE / 8):
			var new_tile = load("res://Board/BoardTile.tscn").instance()
			var tileCode = char(charCounter) + str(numCounter)
			new_tile.init(tileCode, white)
			initialize_piece(char(charCounter), numCounter, new_tile)
			add_child(new_tile)
			new_tile.set_tile_position(Vector2(x, y))
			new_tile.connect("clicked_tile",self,"clicked_tile")
			output.append(new_tile)
			numCounter -= 1
			white = !white
		charCounter += 1
	return output

# helper function for initializing pieces
func load_piece(piece_scene_location, tile, color):
	var piece = load(piece_scene_location).instance()
	piece.init(color, tile.get_tile_code())
	tile.place_piece(piece)

# TODO: initialize piece
func initialize_piece(col, row, tile):
	
#	TODO: initialize tile on this piece eg. tile.place_piece()
	match row:
		# White back row pieces
		1:
			initialize_back_pieces(col, tile, "white")
		# White pawns
		2:
			load_piece("res://Pieces/Pawn.tscn", tile, "white")
			
		# Black pawns
		7:
			load_piece("res://Pieces/Pawn.tscn", tile, "black")
			
		# Black back row pieces 
		8: 
			initialize_back_pieces(col, tile, "black")

func initialize_back_pieces(col, tile, color):
	if (col == "A" || col == "H"):
		load_piece("res://Pieces/Rook.tscn", tile, color)
	elif (col == "B" || col == "G"):
		load_piece("res://Pieces/Knight.tscn", tile, color)
	elif (col == "C" || col == "F"):
		load_piece("res://Pieces/Bishop.tscn", tile, color)
	match col:
		"D":
			load_piece("res://Pieces/King.tscn", tile, color)
		"E":
			load_piece("res://Pieces/Queen.tscn", tile, color)



func show_available_moves():
	pass
