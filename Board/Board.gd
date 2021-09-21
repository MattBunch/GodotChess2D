extends Node2D
class_name Board

const BOARD_SIZE = 480

var board_tile_places = initialize_board()
onready var tiles = get_tree().get_nodes_in_group("Tiles")

var saved_tile

func _ready():
	connect_tiles()

func connect_tiles():
	for tile in tiles:
		tile.connect("clicked_tile",self,"clicked_tile")

func clicked_tile(pos, tile_code):
	
	var tile = get_tile_at_pos(pos)
	if saved_tile == tile:
		print("same tile: ", saved_tile.get_tile_code())
		return
	if saved_tile == null:
		saved_tile = tile
		print("tile saved: ", saved_tile.get_tile_code())
	else:
		print("tile: ",tile.get_tile_code())
		print("saved_tile: ",saved_tile.get_tile_code())
		saved_tile = null

func get_tile_at_pos(pos):
	for tile in tiles:
		if tile != null:
			if tile.get_position() == pos:
				return tile
	
	return null

func initialize_board():
	var A = 65
	var startNum = 8
	var output = []
	var numCounter = startNum
	var charCounter = A
	for x in range(0, BOARD_SIZE, BOARD_SIZE / 8):
		numCounter = startNum
		for y in range(0, BOARD_SIZE, BOARD_SIZE / 8):
			var new_tile = load("res://Board/BoardTile.tscn").instance()
			var tileCode = char(charCounter) + str(numCounter)
			new_tile.init(tileCode)
			add_child(new_tile)
			new_tile.set_tile_position(Vector2(x, y))
			output.append([x, y])
			numCounter -= 1
		charCounter += 1
	return output
