## 19/09/2021

Project started. Learning exercise to figure out godot on my own. Created tile set and structure. A little unclear about how the Board and BoardTile scripts interact with each other and where game logic goes.

Want to initialize:
- proper chess notation positions.

Need to figure out a good method of getting chess pieces initialized. Have a base piece Class, then each piece type class extend that class. Looking forward to that.

## 21/09/2021

Created chess notation positions and updated them on the board. This will make it easier to identify the pieces on the board.

Noticed the background game board doesn't quite line up with the created squares due to the outside boarder in the boarder.svg file. Might have to create my own with exactly 60x60 squares so the borders line up with the squres.