Concept Document: Checkers

Authors: Marielle Riveros and Kevin Gendron

What game are you going to build?

We are going to build Checkers, a game played on a square 10x10 board of alternating light and dark tiles. This is a game for a maximum of two players, and operates on alternating turns between the two. Each player receives 20 pieces to start. The goal of the game is to capture all opposing pieces by jumping over them. The game ends when either a) one player is out of pieces, b) one player cannot move, or c) the game has reached a stalemate in which players are no longer attacking (ie, too many moves have passed without a piece being taken).

Is the game well-specified (e.g. Reversi) or will it require some game work (e.g. a monster battle game)?

This is a well-established game with well-defined rules. As stated above, this is a 2-player game operating on alternating turns. With their initial pieces, players can only move diagonally forward. They can capture opposing pieces by jumping over them, and can link multiple jumps in one turn. This is the only case in which players can move more than one square per turn. Once a player's piece reaches the final row on the opposing player's side, that piece becomes a king. Kings are like normal pieces but can move diagonally backward as well as forward. The game typically ends with one player winning, either by capturing all opposing pieces or by forcing the opposing player into a situation in which they cannot move any pieces. The only time this game ends in a tie is if the game has gone for too many moves without any pieces being jumped, as this implies that players are simply moving around without attacking -- a state which could continue indefinitely. This is something we will have to address.

Is there any game functionality that you’d like to include but may need to cut if you run out of time?

One functionality that may be nice to include would involve showing players their options for each turn. For example, at the beginning of a player's turn we could highlight each piece that is able to be moved during the turn. Once a piece is selected, we could highlight the squares to which that piece can be moved. Depending on how we structure the game, this may be tricky to implement. We also may decide that even if we are able to implement, it would take too much of the strategy out of the game. This leads into another functionality that we may add if we have enough time -- levels of difficulty. If we do want to implement the highlighting feature, one way we could do so is allow users to select an "easy" or "hard" game. In an "easy" game the highlighting would appear for both players, while in a "hard" game there would be no highlighting for either player. This could be an interesting functionality, but may be something we won't have the time to implement.

What challenges do you expect to encounter?

One challenge that we will need to figure out is how to handle multiple jumps in the context of a multiplayer game. In Checkers players are allowed to make multiple jumps in one move if the jumps are linked. Building that functionality into the game, as well as giving the user the option to, or not to, make the double jump is going to become very difficult and something we’ll have to figure out as we go. 
Another thing that may become a challenge is determining the end to a game. If, for instance, two players are left with two kings and continuously move back and forth, that game could come to no end. Therefore, as we mentioned above in our response to the first question, we're going to have to figure out a way to force a tie without intruding on the user's experience. 
