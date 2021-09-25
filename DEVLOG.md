## 19/09/2021

Project started. Learning exercise to figure out godot on my own. Created tile set and structure. A little unclear about how the Board and BoardTile scripts interact with each other and where game logic goes.

Want to initialize:
- proper chess notation positions.

Need to figure out a good method of getting chess pieces initialized. Have a base piece Class, then each piece type class extend that class. Looking forward to that.

## 21/09/2021

Created chess notation positions and updated them on the board. This will make it easier to identify the pieces on the board.

Noticed the background game board doesn't quite line up with the created squares due to the outside boarder in the boarder.svg file. Might have to create my own with exactly 60x60 squares so the borders line up with the squres.

Next goal I want to do is build out my pieces and start initailizing them on the board. Trying to decide how built out the piece class is going to be, I could create it as just a picture of the chess piece and its the board tiles are moving them around and handling mouse clicks, while the chess piece class. Or I could do it so the pieces are a clickable object too. I think I'll need to initialize it that way if I want to have draggable pieces someday, I could imagine that being a big refactor. And the pieces inherit a "place" variable, I don't want to have the chess piece placement logic split between BoardTile.gd and the chess pieces. Really interested to know in GDscript whether the chess pieces inherit the functions of the base parent class and overwrite them. First going to just try with Pawn and ChessPieceBase, then expand to other pieces later.

Had a slight eureka moment while at the gym tonight. Realized that board being an image was, basically, completely pointless because you can just have each individual boardpiece render its own 60px by 60px sprite and render that dynamically upon initialization. So I removed the board sprite and just had the sprites render dynamically in the BoardPiece initialization function. Then I refactored the "Board" scene and accompanying script to "Game" since this is now more of an entry point main function, rather than a visible component. Eventually, I would like the "Game" scene to contain move log and menu options, and not just a board, so this will be expanded sometime too with other scenes/objects.

Interesting to note that GDScript has a ternary operator.

The board will need to flipped and rendered differently based on player white and player black. Thinking about how this is going to be accomplished in code, with a base function ```initialize_board_main``` and then two functions to call main with the different values for board colors, piece placement and tile notations.

Next challenge will be creating the chess pieces on the board and their movesets. Then I will tackle player moves and turns.

## 23/09/2021

Added highlight select squares to show which tile is being selected.

## 25/09/2021

Pieces added. Sprites are in the 1x folder. Need to delete superfluous assets from Assets folder.

Did lots of piece logic and movement today. Got stuck on why the horizontal, vertical and diagonal moves weren't getting stopped by the other pieces