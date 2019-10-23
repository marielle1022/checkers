import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root, channel) {
  ReactDOM.render(<GameBoard channel={channel}/>, root);
}

class GameBoard extends Component {
  constructor(props) {
    super(props)
    this.channel = props.channel;
    this.state = {
        board: this.createSquares() 
    };

    this.channel
        .join()
        .receive("ok", this.got_view.bind(this))
        .receive("error", resp => {console.log("Unable to join", resp); });
    this.channel.on("update", this.got_view.bind(this));
  }

  got_view(view) {
    console.log("new view", view);
    this.setState(view.game);
  }

/*
TODO: The code below can be reformatted. It's duplicated in multiple
spots and I'm sure there's a simple way to put it into a function and alternate
per row.
*/
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

    render() {
      console.log(this.state.board)
      return (
          <div className="game-board">
              {
              this.state.board.map((square, i) => (
                  square.type === 'red' ?
                  <div key={i} className="game-square-red game-square" onClick = {() => 
                      {this.handleClick(i)}}/> :
                  <div key={i} className="game-square-black game-square" onClick = {() => 
                      {this.handleClick(i)}}/>
                  
              ))
              }

          </div>
      );
  }
}

//TODO: Create function for Piece that sends piece clicks
// See hangman/assets/js/hangman.jsx from Nat Tuck "Hangman" repository 
// for reference.
function square(props) {
    return (
      <button className="game-square" onClick={props.onClick}/>
    );
  }
