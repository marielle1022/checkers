import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root, channel) {
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
  */
  
  //TODO: ANYTIME ANYTHING is done, send it to backupagent
class GameBoard extends Component {
  constructor(props) {
    super(props)
    this.channel = props.channel;
    this.board = this.createSquares();
    this.state = {
      board_matrix: {},
      move: [],
      list_dark: {},
      list_light: {},
      total_dark: 20,
      total_light: 20
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

  createSquares() {
      let board = [];
      let square = {};
      let row = 1;
      let col = 1;

      //Alternate colors on the board
      for (let i = 0; i < 100; i++) {
          if (col > 10) {
              col = 1;
              row++;
          }
          //Even rows
          if (row % 2 === 0) {
              if (i % 2 === 0) {
                  board.push({
                      square,
                      row: row,
                      col: col,
                      type: "red"
                  })
              } else {
                  board.push({
                      square,
                      row: row,
                      col: col,
                      type: "black"
                  })
              }

          //Odd rows
          } else {
              if (i % 2 === 0) {
                  board.push({
                      square,
                      row: row,
                      col: col,
                      type: "black"
                  })
              } else {
                  board.push({
                      square,
                      row: row,
                      col: col,
                      type: "red"
                  })
              }
          }
          //Increment row
          col++;
      }
      return board;
  }


    handleClick(ev) {
        this.channel.push("click", { move: ev })
        .receive("ok", this.got_view.bind(this));
    }

  //TODO: add in div for pieces -- use amtrix map?
  // TODO: should onclick be in this.board or in this.state.board_matrix?
    render() {
        console.log(this.board)
        a = this.state.board_matrix.get(1)
        b = a.get(1)
        console.log("VALUE " + a)
        return (
            <div className="game-board">
                {
                this.board.map((square, i) => (

                    square.type === 'red' ?
                    <div key={i} className="game-square-red game-square" /> :
                    <div key={i} className="game-square-black game-square" />
                ))
                }

            </div>
        );
    }
}

