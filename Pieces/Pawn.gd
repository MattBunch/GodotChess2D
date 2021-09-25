extends ChessPieceBase 

var can_promote = false
var first_move = true

func _ready():
	print("I am a pawn and I am initialized")

func move():
	# if first move, move two spaces in front
	# else, move one piece in front
	pass
	
func upgrade_pawn():
	# if at last row of board, upgrade to knight, bishop, rook or queen
	pass
