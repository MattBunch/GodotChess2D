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

# remove moves that don't affect check
func remove_moves_for_check(check_moves):
	var output= []
	for move in get_available_moves():
		for check_move in check_moves:
			if move == check_move:
				output.append(move)
	
	print(output)
	set_available_moves(output)
	
func get_check_moves(king_tile_code):
	var king_col = king_tile_code[0]
	var king_row = king_tile_code[1]
	for move in get_available_moves():
		var move_col = move[0]
		var move_row = move[1]
	pass

# used for pawns, knights, kings,
func remove_friendly_occupied_tiles(input_available_moves, friendly_occupied_tile_codes):
	for friendly_tile in friendly_occupied_tile_codes:
		for move in input_available_moves:
			if move == friendly_tile:
				input_available_moves.erase(move)

# rooks (horizontal, vertical), bishops(diagonal) queens (uses both)

func get_all_vertical_moves(board, enemy_occupied_tiles, friendly_occupied_tiles):
	var output = []
	# negative
	var row_num_neg = int(get_row())
	var is_blocked_neg = false
	
	while(row_num_neg > 0):
		row_num_neg -= 1
		var tile_code = get_col() + str(row_num_neg)
		
		if !(is_blocked_neg):
			is_blocked_neg = check_for_piece(tile_code, board, output)
		
		if !(is_blocked_neg):
			output.append(tile_code)
	
	
	# positive
	var row_num_pos = int(get_row())
	var is_blocked_pos = false
	
	while(row_num_pos < 8):
		row_num_pos += 1
		var tile_code = get_col() + str(row_num_pos)
		if !(is_blocked_pos):
			is_blocked_pos = check_for_piece(tile_code, board, output)
		
		if !(is_blocked_pos):
			output.append(tile_code)
	
		
	return output

func get_all_horizontal_moves(board, enemy_occupied_tiles, friendly_occupied_tiles):
	var output = []
	
	# negative
	var col_num_neg = ord(get_col())
	var is_blocked_neg = false
	while(col_num_neg > ord("A")):
		col_num_neg -= 1
		var tile_code = char(col_num_neg) + get_row()
		if !(is_blocked_neg):
			is_blocked_neg = check_for_piece(tile_code, board, output)
		
		if !(is_blocked_neg):
			output.append(tile_code)

	# positive
	var col_num_pos = ord(get_col())
	var is_blocked_pos = false
	
	while(col_num_pos < ord("H")):
		col_num_pos += 1
		var tile_code = char(col_num_pos) + get_row()
		if !(is_blocked_pos):
			is_blocked_pos = check_for_piece(tile_code, board, output)
		
		if !(is_blocked_pos):
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
		
		if !(is_blocked_up_left):
			is_blocked_up_left = check_for_piece(tile_code, board, output)
		
		if !(is_blocked_down_left):
			is_blocked_down_left = check_for_piece(tile_code_2, board, output)
		
		if !(is_blocked_up_left):
			output.append(tile_code)
		if !(is_blocked_down_left):
			output.append(tile_code_2)
	
#	 right
	var col_up_right = col_num
	var row_up_right = int(get_row())
	var row_down_right = int(get_row())
	
	var is_blocked_up_right = false
	var is_blocked_down_right = false
	while(col_up_right < ord("H")):
		col_up_right += 1
		row_up_right += 1
		row_down_right -= 1
		var tile_code = char(col_up_right) + str(row_up_right)
		var tile_code_2 = char(col_up_right) + str(row_down_right)

		if !(is_blocked_up_right):
			is_blocked_up_right = check_for_piece(tile_code, board, output)
		
		if !(is_blocked_down_right):
			is_blocked_down_right = check_for_piece(tile_code_2, board, output)
		
		if !(is_blocked_up_right):
			output.append(tile_code)
		if !(is_blocked_down_right):
			output.append(tile_code_2)
	
		
	return output

func does_contain_piece(tile_code, board):
	for tile in board:
		if tile.get_tile_code() == tile_code && tile.has_board_piece():
			return tile.get_board_piece()
	return null

func check_for_piece(tile_code, board, input_moves):
		var piece = does_contain_piece(tile_code, board)
		if (piece != null):
			var same_color = piece.get_color() == get_color()
			if same_color:
				return true
			else:
				input_moves.append(tile_code)
				return true
		return false

# TODO: write out function to take out moves that don't prevent check
# gonna have to take in enemy's moves
func can_stop_check():
	pass

func remove_invalid_codes(input_array):
	var moves_to_remove = []
	for tile_code in input_array:
		if !(is_valid_code(tile_code)):
			moves_to_remove.append(tile_code)
		
	for i in moves_to_remove:
		for j in input_array:
			if i == j:
				input_array.erase(j)

func is_valid_code(input_code):
	print("col: ", input_code[0])
	print("row: ", input_code[1])
	print("length: "+str(input_code.length()))
	if input_code.length() > 2:
		return false
	return is_valid_col(ord(input_code[0])) && is_valid_row(int(input_code[1]))

func is_valid_col(col):
	print(col)
	print(ord("A"))
	print(ord("H"))
	return col >= ord("A") && col <= ord("H")

func is_valid_row(row):
	return row > 1 && row < 8

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
