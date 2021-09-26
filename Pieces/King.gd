extends ChessPieceBase 

var can_check = true

func move():
	can_check = false

func is_in_check(board):
	for tile in board:
		if tile.has_board_piece():
			var piece = tile.get_board_piece()
			if piece.get_color() != get_color():
				if piece.get_available_moves().has(get_tile_code()):
					print(get_color() + " king" + " is in check")
					# TODO: get pieces that cause check
					return [true, self, piece.get_available_moves()]
	print(get_color() + " king" + " is NOT in check")
	return [false, self, []]

func update_available_moves(_board, _enemy_occupied_tiles, friendly_occupied_tiles):
	# just get every surrounding note code
	set_available_moves([])
	
	# top:
	
	var code_above = get_col() + str(int(get_row()) + 1)
	var code_above_right = char(ord(get_col()) + 1)  + str(int(get_row()) + 1)
	var code_above_left = char(ord(get_col()) - 1) + str(int(get_row()) + 1) 
	
	# below
	
	var code_below = get_col() + str(int(get_row()) - 1)
	var code_below_right = char(ord(get_col()) + 1)  + str(int(get_row()) - 1)
	var code_below_left = char(ord(get_col()) - 1) + str(int(get_row()) - 1)
	
	# sides
	
	var code_right = char(ord(get_col()) + 1)  + get_row()
	var code_left = char(ord(get_col()) - 1) + get_row()
	
	var output = [
		code_above,
		code_above_right,
		code_above_left,
		code_below,
		code_below_right,
		code_below_left,
		code_right,
		code_left
	]
	
	remove_friendly_occupied_tiles(output, friendly_occupied_tiles)
	
	set_available_moves(output)
