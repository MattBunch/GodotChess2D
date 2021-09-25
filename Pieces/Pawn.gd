extends ChessPieceBase

var can_promote = false
var first_move = true


func move():
	# if first move, set first_move to false
	first_move = false
	# else, place piece
	if can_promote:
		promote_pawn()
	

# TODO: write out functionality for upgrading

func can_promote():
#	if not on last row (8 for white, 1 for black) return false
	pass
	# else return true

func promote_pawn():
	# if at last row of board, upgrade to knight, bishop, rook or queen
	pass
	
func update_available_moves(board, enemy_occupied_tiles, friendly_occupied_tiles):
	set_available_moves([])
	var output = []
	
	var code_above = get_col() + str(int(get_row()) + 1)
	var code_below = get_col() + str(int(get_row()) - 1)
	
	var code_above_2 = get_col() + str(int(get_row()) + 2)
	var code_below_2 = get_col() + str(int(get_row()) - 2)
	
#	TODO: build out pawn take piece diagonally conditions
	var code_above_take_right = char(ord(get_col()) + 1)  + str(int(get_row()) + 1)
	var code_above_take_left = char(ord(get_col()) - 1) + str(int(get_row()) + 1) 
	
	var code_below_take_right = char(ord(get_col()) + 1)  + str(int(get_row()) - 1)
	var code_below_take_left = char(ord(get_col()) - 1) + str(int(get_row()) - 1)

	# one space up
	if color == "white":
		if (!enemy_occupied_tiles.has(code_above) || friendly_occupied_tiles.has(code_above)):
			output.append(code_above)

		if (enemy_occupied_tiles.has(code_above_take_right)):
			output.append(code_above_take_right)

		if (enemy_occupied_tiles.has(code_above_take_left)):
			output.append(code_above_take_left)
		
			
	elif color == "black":
		if (!enemy_occupied_tiles.has(code_below) || friendly_occupied_tiles.has(code_below)):
			output.append(code_below)
			
		if (enemy_occupied_tiles.has(code_below_take_right)):
			output.append(code_below_take_right)
			
		if (enemy_occupied_tiles.has(code_below_take_left)):
			output.append(code_below_take_left)

	# if first_move, two spaces
	if first_move:
		var all_occupied_tiles = enemy_occupied_tiles + friendly_occupied_tiles
		
		if color == "white":
			if !(all_occupied_tiles.has(code_above) || all_occupied_tiles.has(code_above_2)):
				output.append(code_above_2)
		
		elif color == "black":
			if !(all_occupied_tiles.has(code_below) || all_occupied_tiles.has(code_below_2)):
				output.append(code_below_2)
	
	remove_friendly_occupied_tiles(output, friendly_occupied_tiles)
	
	set_available_moves(output)
