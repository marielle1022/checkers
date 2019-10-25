import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root, channel) {
    console.log("sindei" );
    console.log(channel)
  ReactDOM.render(<GameBoard channel={channel}/>, root);
}

/* In state...
    board_matrix = coordinates of all squares and their values
    *NB: Should we store current piece? Or just access it from click list?
    move = up to 2 valid clicks
    list_dark = list of all pieces, with
        (keys = board coordinates) : (values = map including rank, team, x, y)
    list_light = list of all pieces, with
        (keys = board coordinates) : (values = map including rank, team, x, y)
    *NB: should both lists of pieces be here? Or just the piece being modified?
    Can we access piece being modified without having lists here?
    total_dark = number of dark dark pieces
    total_light = number of light pieces
    *NB: need total numbers because there doesn't seem to be a simple way to seem
          if a map is empty

    Referenced https://upmostly.com/tutorials/react-onclick-event-handling-with-examples  
    to help structure the onclick functions within the dark and light tiles (and possibly
        the board_matrix. This was written before that was completed)
  */

  //TODO: ANYTIME ANYTHING is done, send it to backupagent
class GameBoard extends Component {
  constructor(props) {
    super(props)
    this.channel = props.channel;
    this.state = {
      board_matrix: {},
      move: [],
      list_dark: {},
      list_light: {},
      total_dark: 20,
      total_light: 20,
      move: []
    };

    this.channel
        .join()
        .receive("ok", this.got_view.bind(this))
        .receive("error", resp => {console.log("Unable to join", resp); });
    
        console.log("after join")
        this.channel.on("update", this.got_view.bind(this));
    }

    got_view(view) {
        console.log("new view", view);
        this.setState(view.game);
    }

    handleClick = (piece) => {
        let move = this.state.move;
        if (move.length == 0) {
            let val1 = piece.row;
            let val2 = piece.col;
            let team = piece.value;
            move.push(val1);
            move.push(val2)
            move.push(team)
            console.log("val1: " + val1 + " val2: " + val2 + " team: " + team)
            this.setState({
                move: move
            })
        }
        console.log("move so far: ")
        console.log(this.state.move)
    }


    tileClick = (tile) => {
        let move = this.state.move;
        console.log("tile clicked")
        if (move.length == 3) {
            let val1 = tile.row;
            let val2 = tile.col;
            move.push(val1);
            move.push(val2)
            this.setState({
                move: move
            })
            this.channel.push("click", { move: move })
            .receive("ok", this.got_view.bind(this));
        }
        console.log("in tileclick ")
        move = []
        this.setState({
            move: move
        })
        console.log(this.state.move)
    }

    handleClick() {
        console.log("Clicked!")

        this.channel.push("click", { move: ev })
        .receive("ok", this.got_view.bind(this));
    }

    createDarkPieces() {
        let dark_pieces = [];
        for (let i of Object.values(this.state.list_dark)) {
            // Store the piece from elixir
            // in an array
            let piece = [];
            let value_1 = i
            for (let j of Object.values(value_1)){
                let val = j
                piece.push(val)
            }
            // Push that piece into the dark_pieces array
            dark_pieces.push(
                {
                    row: piece[0],
                    col: piece[1],
                    rank: piece[2],
                    team: piece[3],
                    value: 1
                }
            )
        }
        return dark_pieces;
    }

    createLightPieces() {
        let light_pieces = [];
        for (let i of Object.values(this.state.list_light)) {
            // Store the piece from elixir
            // in an array
            let piece = [];
            let value_1 = i
            for (let j of Object.values(value_1)){
                let val = j
                piece.push(val)
            }
            // Push that piece into the dark_pieces array
            light_pieces.push(
                {
                    row: piece[0],
                    col: piece[1],
                    rank: piece[2],
                    team: piece[3],
                    value: 2
                }
            )
        }
        return light_pieces;
    }

    // Converts the map from elixir to format that's easily
    // readable by react
    createBoardMatrix() {

        let board_matrix = [];
        let row = 0;
        let col = 0;
        let tile = {};
        for (let i of Object.values(this.state.board_matrix)) {
            let value_1 = i
            for (let j of Object.values(value_1)){
                let val = j
                // If a piece cannot be placed on the tile
                if (val < 0) {
                    board_matrix.push(
                        {
                            tile,
                            row: row,
                            col: col,
                            value: val,
                            type: "black"
                        }
                    )
                }
                // If the tile is valid and/or occupied
                else {
                    board_matrix.push(
                        {
                            tile,
                            row: row,
                            col: col,
                            value: val,
                            type: "red"
                        }
                    ) 
                }
                if (col > 8) {
                    col = -1;
                }
                col++
            }
            row++;
        }
        return board_matrix;
    }

    render() {

        // Update pieces + board
        let board = this.createBoardMatrix();
        let dark_players = this.createDarkPieces();
        let light_players = this.createLightPieces();

        return (
            <div className="game-board">

                {
                board.map((tile, i) => (
                    tile.type === 'red' ?
                    <div 
                        key={i} 
                        className="game-square-red game-square" 
                        style={
                            {
                            gridRow: tile.row + 1,
                            gridColumn: tile.col + 1
                        }
                        }
                        onClick = {() => {this.tileClick(tile)}}                    
                    /> :
                    <div 
                        key={i} 
                        className="game-square-black game-square" 
                        style={
                            {
                            gridRow: tile.row + 1,
                            gridColumn: tile.col + 1
                            }
                        }
                    
                    />
                ))
                }

                {
                dark_players.map((piece, i) => {
                    return (
                    <div
                        key={i}
                        style={{
                            gridRow: piece.row + 1,
                            gridColumn: piece.col + 1
                        }}
                        className={piece.team}

                        >
                    </div>
                    )
                })
                }

                {
                light_players.map((piece, i) => {
                    return (
                    <div
                        key={i}
                        style={{
                            gridRow: piece.row + 1,
                            gridColumn: piece.col + 1
                        }}
                        className={piece.team}

                        onClick = {() => {this.handleClick(piece)}}                    
                        >
                    </div>
                    )
                })
                }

            </div>
        );
    }
}

