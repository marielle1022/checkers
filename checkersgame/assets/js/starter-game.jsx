import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
  ReactDOM.render(<GameBoard />, root);
}

class GameBoard extends Component {
  state = {
      board: this.createSquares() 
  };

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

  //TODO: This is where we'll insert the channel push
  handleClick = (square, i) => {
      console.log("Row: " + square.row + ", Col: " + square.col)
  }

  render() {
      console.log(this.state.board)
      return (
          <div className="game-board">
              {
              this.state.board.map((square, i) => (
                  square.type === 'red' ?
                  <div key={i} className="game-square-red" onClick = {() => 
                      {this.handleClick(square,i)}}/> :
                  <div key={i} className="game-square-black" onClick = {() => 
                      {this.handleClick(square,i)}}/>
                  
              ))
              }

          </div>
      );
  }
}
