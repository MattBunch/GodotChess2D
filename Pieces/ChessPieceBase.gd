extends Node2D
class_name ChessPieceBase

var color setget set_color, get_color
var tile_code setget set_tile_code, get_tile_code
var available_moves = [] setget set_available_moves, get_available_moves
# TODO: build out move history
var move_history = [] setget set_move_history, get_move_history

func init(color, tile_code):
	self.color = color
	self.tile_code = tile_code
	self.set_color_sprite()
	pass
	
func set_color_sprite():
	match self.color:
		"white":
			get_node("BlackSprite").visible = false
		"black":
			get_node("WhiteSprite").visible = false

func move():
	pass

# TODO: build out these moves in each chess piece class
func update_available_moves(board, enemy_occupied_tile_codes, friendly_occupied_tile_codes):
	pass

# used for pawns, knights, kings,
func remove_friendly_occupied_tiles(input_available_moves, friendly_occupied_tile_codes):
	for friendly_tile in friendly_occupied_tile_codes:
		for move in input_available_moves:
			if move == friendly_tile:
				input_available_moves.erase(move)

# rooks (horizontal, vertical), bishops(diagonal) queens (uses both)

func get_all_vertical_moves(board, enemy_occupied_tiles, friendly_occupied_tiles):
	# negative
	var output = []
	
	for n in range(8, get_row(), -1):
		var tile_code = get_col() + str(n)
		output.append(tile_code)
	
	# positive
	for n in range(1, get_row()):
		var tile_code = get_col() + str(n)
		output.append(tile_code)
		
	
	return output

func get_all_horizontal_moves(board, enemy_occupied_tiles, friendly_occupied_tiles):
	var output = []
	var col_num = ord(get_col())
	# negative
	for n in range(ord("H"), col_num, -1):
		var tile_code = char(n) + get_row()
		output.append(tile_code)
	
	# positive
	for n in range(ord("A"), col_num):
		var tile_code = char(n) + get_row()
		output.append(tile_code)
	
	return output

func get_all_diagonal_moves(board):
	var output = []
	var col_num = ord(get_col())
	
	#  left
	var col_up_left = col_num
	var row_up_left = int(get_row())
	var row_down_left = int(get_row())
	var is_blocked_up_left = false
	var is_blocked_down_left = false
	
	while(col_up_left > ord("A")):
		col_up_left -= 1
		row_up_left -= 1
		row_down_left += 1
		var tile_code = char(col_up_left) + str(row_up_left)
		var tile_code_2 = char(col_up_left) + str(row_down_left)
		print("A row_up: ", tile_code)
		print("A row_down: ", tile_code_2)
		output.append(tile_code)
		output.append(tile_code_2)
#
#	col_up_left = col_num
#	while(col_up_left > ord("A")):
#		col_up_left -= 1
#		row_up_left -= 1
#		row_down_left += 1
#		var tile_code = char(col_up_left) + str(row_up_left)
#		var tile_code_2 = char(col_up_left) + str(row_down_left)
#		print("A row_up: ", tile_code)
#		print("A row_down: ", tile_code_2)
#		output.append(tile_code)
#		output.append(tile_code_2)
	
#	 right
	var col_up_right = col_num
	var row_up_right = int(get_row())
	var row_down_right = int(get_row())
	while(col_up_right < ord("H")):
		col_up_right += 1
		row_up_right += 1
		row_down_right -= 1
		var tile_code = char(col_up_right) + str(row_up_right)
		var tile_code_2 = char(col_up_right) + str(row_down_right)
		print("H row_up: ", tile_code)
		print("H row_down: ", tile_code_2)
		output.append(tile_code)
		output.append(tile_code_2)
		
	return output

func is_blocked(tile_code, board):
	for tile in board:
		if tile.get_tile_code() == tile_code:
			return true
	return false

# TODO: write out function to take out moves that don't prevent check
# gonna have to take in enemy's moves
func can_stop_check():
	pass

func remove_illegitimate_tile_codes(input_moves):
	for move in input_moves:
		var move_col = ord(move[0])
		var move_row = int(move[1])
		print(move_col)
		print(move_row)
		print(ord("A"))
		
		var invalid_col =  (move_col > ord("A") || move_col < ord("H"))
		var invalid_row = (move_row < 1 || move_row > 8)
		if (invalid_col || invalid_row):
			print("REMOVING TILE: ", move)
			input_moves.remove(move)


# TODO: write out way of blocking movement for rooks, kings, knights, 

func get_color():
	return color

func set_color(input):
	color = input

func get_available_moves():
	return available_moves

func set_available_moves(input):
	available_moves = input

func get_move_history():
	return move_history

func set_move_history(input):
	move_history = input

func add_to_move_history(input):
	get_move_history().append(input)

func get_tile_code():
	return tile_code

func set_tile_code(input):
	tile_code = input

func get_col():
	return get_tile_code()[0]
	
func get_row():
	return get_tile_code()[1]
