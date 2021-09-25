extends ChessPieceBase 

func update_available_moves(board, enemy_occupied_tiles, friendly_occupied_tiles):

	set_available_moves([])
	var output = []

	var diagonal_moves = get_all_diagonal_moves(board)
	
	output = diagonal_moves
	
	set_available_moves(output)
