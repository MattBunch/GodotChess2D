extends Node2D
class_name Game

const BOARD_SIZE = 480

# array to hold all tiles
# REFACTOR: rename to board
onready var tiles = initialize_board()

# label info
# TODO: create move history label as well
onready var label = initialize_info_board()

# tile that user clicks on
var saved_tile

# turn system
var turn = "white"
var turn_count = 1
var game_over = false
var winning_player

# piece has to have its available moves updated after the tiles on the board has all been initialized
func _ready():
	update_all_pieces_available_moves()

func clicked_tile(tile_code):
	if game_over:
		return
	
	var tile = get_tile_at_code(tile_code)

	if saved_tile == tile:
		print("same tile: ", saved_tile.get_tile_code())
		unselect_tile()

	elif saved_tile == null:
		select_tile(tile)

	else:
		print("tile: ",tile.get_tile_code())
		print("saved_tile: ",saved_tile.get_tile_code())
		
		# select the new targeted tile
		# elif target tile is place the piece can move to (empty or contains enemy), process move
		
		# TODO: refactor winning conditions, its spaghetti nonsense right now
		if (saved_tile.has_board_piece() && saved_tile.get_board_piece().get_color() == turn
		&& saved_tile.get_board_piece().get_available_moves().has(tile.get_tile_code())):
			print("\nMOVING PIECE: ", saved_tile.get_tile_code(), tile.get_tile_code())
			var moving_piece = saved_tile.get_board_piece()
			saved_tile.remove_piece(moving_piece)
			# temporary check handler
			if (tile.has_board_piece()):
				var removing_piece = tile.get_board_piece()
				if (removing_piece.get_name() == "King"):
					winning_player = moving_piece.get_color()
					label.text = winning_player + " is the winner!"
					game_over = true
					# end game
				tile.remove_piece(removing_piece)
			tile.place_piece(moving_piece, tiles)
			moving_piece.add_to_move_history(saved_tile.get_tile_code())
			moving_piece.set_tile_code(tile.get_tile_code())
			moving_piece.move()
			# TODO: get check/checkmate status here, find how to affect available moves somehow
			# if double checked:
				# only king can move
			# elif single checked
#				Capture of checking piece. The capturing piece is not absolutely pinned
#				King moves to non attacked squares, sliding check x-rays the king
#    			Interposing moves in case of distant sliding check. The moving piece is not absolutely pinned.
			update_all_pieces_available_moves()
#			TODO: work with check handler somehow
			var check_handle = check_handler(turn)
			print("\ncheck_handle: ")
			print(check_handle[0])
			if(check_handle[0]):
				update_all_pieces_check_moves(check_handle[2])
#			TODO: check for checkmate, check for draw
			hide_available_moves()
			next_turn()
		# else select new tile
		else:
			print("\nSELECTING NEW TILE")
			unselect_tile()
			select_tile(tile)

# TODO: work on check_handler for proper check functionality
func check_handler(color):
	for tile in tiles:
		if tile.has_board_piece():
			var piece = tile.get_board_piece()
			if piece.get_name() == "King" && piece.get_color() != color:
				return piece.is_in_check(tiles)

func next_turn():
	turn_count += 1
	if turn_count % 2 == 0:
		turn = "black"
	elif turn_count % 1 == 0:
		turn = "white"
	var text_input = get_info_text()
	if (game_over):
		text_input += "\nWinning player is " + winning_player + "!"
	label.text = text_input

func select_tile(tile):
	saved_tile = tile
	saved_tile.set_selected(true)
	if (saved_tile.has_board_piece() && tile.get_board_piece().get_color() == turn):
		var moves = saved_tile.get_board_piece().get_available_moves()
		show_available_moves(moves)
		print("moves: ", moves)
		print("I have a piece: ", saved_tile.get_board_piece().get_name())
	print("saved_tile.has_board_piece: ", saved_tile.has_board_piece())
	print("tile saved: ", saved_tile.get_tile_code())

func unselect_tile():
	saved_tile.set_selected(false)
	saved_tile = null
	hide_available_moves()

# will draw sprite on each tile
func show_available_moves(moves):
	for tile in tiles:
		for move in moves:
			if (tile.get_tile_code() == move):
				print('Match: ', move)
				tile.show_move_sprite()

func hide_available_moves():
	for tile in tiles:
		tile.hide_move_sprite()

func update_all_pieces_available_moves():
	for tile in tiles:
		if (tile.has_board_piece()):
			tile.get_board_piece().update_available_moves(tiles, get_occupied_tiles(tile, true), get_occupied_tiles(tile, false))
#			TODO: figure out better way of filtering invalid tiles than this, slows down game too much
#			tile.get_board_piece().remove_illegitimate_tile_codes(tile.get_board_piece().get_available_moves())

func update_all_pieces_check_moves(check_moves):
	for tile in tiles:
		if (tile.has_board_piece()):
			tile.get_board_piece().remove_moves_for_check(check_moves)

# REFACTOR: for loop is a little repetitive
func get_occupied_tiles(inputTile, enemy):
	var output = []
	for tile in tiles:
		if tile.has_board_piece():
			if enemy:
				if tile.get_board_piece().get_color() != inputTile.get_board_piece().get_color():
					output.append(tile.get_tile_code())
			else:
				if tile.get_board_piece().get_color() == inputTile.get_board_piece().get_color():
					output.append(tile.get_tile_code())
	
	return output

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

#  _____       _ _   _       _ _          _   _             
# |_   _|     (_) | (_)     | (_)        | | (_)            
#   | |  _ __  _| |_ _  __ _| |_ ______ _| |_ _  ___  _ __  
#   | | | '_ \| | __| |/ _` | | |_  / _` | __| |/ _ \| '_ \ 
#  _| |_| | | | | |_| | (_| | | |/ / (_| | |_| | (_) | | | |
# |_____|_| |_|_|\__|_|\__,_|_|_/___\__,_|\__|_|\___/|_| |_|
#


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
			var col = char(charCounter)
			var tileCode = col + str(numCounter)
			new_tile.init(tileCode, white)
			initialize_piece(col, numCounter, new_tile)
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
	tile.place_piece(piece, tiles)

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
			
func get_info_text():
	return "turn: " + turn + "\n" + "turn count: " + str(turn_count)

func initialize_info_board():
	var new_label = Label.new()
	new_label.text = get_info_text()
	new_label.rect_position = Vector2(500, 0)
	add_child(new_label)
	return new_label


#
#  _____       _                 
# |  __ \     | |                
# | |  | | ___| |__  _   _  __ _ 
# | |  | |/ _ \ '_ \| | | |/ _` |
# | |__| |  __/ |_) | |_| | (_| |
# |_____/ \___|_.__/ \__,_|\__, |
#                           __/ |
#                          |___/ 
#
# DEBUG: for removing pieces
#
func _input(event):
	if Input.is_key_pressed(KEY_D):
		for tile in tiles:
			if tile.has_board_piece():
				var piece = tile.get_board_piece()
				var piece_name = piece.get_name()
				var valid_names = ["King", "Bishop", "Rook"]
				if !(valid_names.has(piece_name)):
					tile.remove_piece(piece)
					update_all_pieces_available_moves()
