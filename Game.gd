extends Node2D
class_name Game

const BOARD_SIZE = 480

var board_tile_places = initialize_board()
onready var tiles = get_tree().get_nodes_in_group("Tiles")

var saved_tile

func _ready():
	connect_tiles()
	initialize_pieces()

func connect_tiles():
	for tile in tiles:
		tile.connect("clicked_tile",self,"clicked_tile")

func clicked_tile(pos, tile_code):
	# TODO: change these tiles' commands into individual functions 
	# eg:
		# select square
		# deselect square
		# process move

	var tile = get_tile_at_code(tile_code)

	if saved_tile == tile:
		print("same tile: ", saved_tile.get_tile_code())
		unselect_tile()
		return

	if saved_tile == null:
		select_tile(tile)
		print("tile saved: ", saved_tile.get_tile_code())
		
	else:
		print("tile: ",tile.get_tile_code())
		print("saved_tile: ",saved_tile.get_tile_code())
		# TODO: process moves between the two tiles here
		# if tile is empty or tile contains piece of the same color, select new tile
		# elif tile has enemy piece check if can move
		unselect_tile()

func select_tile(tile):
	saved_tile = tile
	saved_tile.set_selected(true)

func unselect_tile():
	saved_tile.set_selected(false)
	saved_tile = null

# TODO: possibly delete this func since I am now moving to code based selection of tiles
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
			add_child(new_tile)
			new_tile.set_tile_position(Vector2(x, y))
			output.append([x, y])
			numCounter -= 1
			white = !white
		charCounter += 1
	return output

func initialize_pieces():
	for x in tiles:
		print(x.get_tile_code())
		# TODO: initialize pieces based on code tile starting positions

func show_available_moves():
	pass
