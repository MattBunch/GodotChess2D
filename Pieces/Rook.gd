extends ChessPieceBase 


func update_available_moves(board, enemy_occupied_tiles, friendly_occupied_tiles):

	set_available_moves([])
	var output = []
	var horizontal_moves = get_all_horizontal_moves(board, enemy_occupied_tiles, friendly_occupied_tiles)
	var vertical_moves = get_all_vertical_moves(board, enemy_occupied_tiles, friendly_occupied_tiles)
	
	output = horizontal_moves + vertical_moves
	
	set_available_moves(output)
