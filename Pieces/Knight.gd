extends ChessPieceBase 


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func move():
	pass

func update_available_moves(board, enemy_occupied_tiles, friendly_occupied_tiles):
#	var code_above_take_right = char(ord(get_col()) + 1)  + str(int(get_row()) + 1)
#	var code_above_take_left = char(ord(get_col()) - 1) + str(int(get_row()) + 1) 
	
	var output = []
	
	set_available_moves([])
	# up left = row + 2 col - 1 
	# up right = row + 2 col + 1
	var code_up_left = char(ord(get_col()) - 1)  + str(int(get_row()) + 2)
	var code_up_right = char(ord(get_col()) + 1)  + str(int(get_row()) + 2)
	
	# down left = row - 2 col - 1 
	# down right = row - 2 col + 1 
	
	var code_down_left = char(ord(get_col()) - 1)  + str(int(get_row()) - 2)
	var code_down_right = char(ord(get_col()) + 1)  + str(int(get_row()) - 2)
	
	# left up row + 1 col + 2
	# left down row - 1 col + 2
	
	var code_left_up = char(ord(get_col()) + 2)  + str(int(get_row()) + 1)
	var code_left_down = char(ord(get_col()) + 2)  + str(int(get_row()) - 1)

	# right up row + 1 col - 2
	# right down row - 1 col - 2
	var code_right_up = char(ord(get_col()) - 2)  + str(int(get_row()) + 1)
	var code_right_down = char(ord(get_col()) - 2)  + str(int(get_row()) - 1)

#	remove_invalid_codes(output)
# new way of doing codes, don't know if its faster
	if(is_valid_code(code_up_left)):
		output.append(code_up_left)
	if(is_valid_code(code_up_right)):
		output.append(code_up_right)
	if(is_valid_code(code_down_left)):
		output.append(code_down_left)
	if(is_valid_code(code_down_right)):
		output.append(code_down_right)
	if(is_valid_code(code_left_up)):
		output.append(code_left_up)
	if(is_valid_code(code_left_down)):
		output.append(code_left_down)
	if(is_valid_code(code_right_up)):
		output.append(code_right_up)
	if(is_valid_code(code_right_down)):
		output.append(code_right_down)
	
	remove_friendly_occupied_tiles(output, friendly_occupied_tiles)
	
	set_available_moves(output)

