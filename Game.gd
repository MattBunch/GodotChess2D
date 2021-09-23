extends Node2D
class_name Game

const BOARD_SIZE = 480

# array to hold all tiles
# can't use onready because board has to be initialized first
var tiles

# tile that user clicks on
var saved_tile

func _ready():
	initialize_board()
	tiles = get_tree().get_nodes_in_group("Tiles")

func clicked_tile(pos, tile_code):
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

func select_tile(tile):
	saved_tile = tile
	saved_tile.set_selected(true)

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

# REFACTOR: tiles is already an array of all tiles on page when they get created, 
# so this function doesn't need to return anything
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

# TODO: initialize piece
func initialize_piece(col, row, tile):
	
#	TODO: initialize tile on this piece eg. tile.place_piece()
	match row:
		# White back row pieces
		1:
			match col:
				"A":
					print("rook")
				"B":
					print("knight")
				"C":
					print("bishop")
				"D":
					print("king")
				"E":
					print("queen")
				"F":
					print("bishop")
				"G":
					print("knight")
				"H":
					print("rook")
					
		# White pawns
		2:
			print("white pawn: ", row, col)
			
		# Black pawns
		7:
			print("black pawn: ", row, col)
			
		# Black back row pieces 
		8: 
			match col:
				"A":
					print("rook")
				"B":
					print("knight")
				"C":
					print("bishop")
				"D":
					print("king")
				"E":
					print("queen")
				"F":
					print("bishop")
				"G":
					print("knight")
				"H":
					print("rook")

func show_available_moves():
	pass
