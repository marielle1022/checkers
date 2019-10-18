defmodule Checkersgame.Board do
  # Note: Is this alias only usable within this module?
  # Question: Should Piece module be nexted within this?
  alias Checkersgame.Board, as: Board

  defstruct

  def new do
    %{
      # set up matrix
      # Question: how to define this so it can be updated at each move? Is it possible?
      board: create_board()
    }
  end

  # To create nested map, used
  # https://blog.danielberkompas.com/2016/04/23/multidimensional-arrays-in-elixir/
  def create_board do
    # Dark squares (the only ones being used) will be represented with 0
    # Light squares (which won't be used) will be represented with -1
    starting_board = %{
      0 => %{0 => 0, 1 => -1, 2 => 0, 3 => -1, 4 => 0, 5 => -1, 6 => 0, 7 => -1, 8 => 0, 9 => -1},
      1 => %{0 => -1, 1 => 0, 2 => -1, 3 => 0, 4 => -1, 5 => 0, 6 => -1, 7 => 0, 8 => -1, 9 => 0},
      2 => %{0 => 0, 1 => -1, 2 => 0, 3 => -1, 4 => 0, 5 => -1, 6 => 0, 7 => -1, 8 => 0, 9 => -1},
      3 => %{0 => -1, 1 => 0, 2 => -1, 3 => 0, 4 => -1, 5 => 0, 6 => -1, 7 => 0, 8 => -1, 9 => 0},
      4 => %{0 => 0, 1 => -1, 2 => 0, 3 => -1, 4 => 0, 5 => -1, 6 => 0, 7 => -1, 8 => 0, 9 => -1},
      5 => %{0 => -1, 1 => 0, 2 => -1, 3 => 0, 4 => -1, 5 => 0, 6 => -1, 7 => 0, 8 => -1, 9 => 0},
      6 => %{0 => 0, 1 => -1, 2 => 0, 3 => -1, 4 => 0, 5 => -1, 6 => 0, 7 => -1, 8 => 0, 9 => -1},
      7 => %{0 => -1, 1 => 0, 2 => -1, 3 => 0, 4 => -1, 5 => 0, 6 => -1, 7 => 0, 8 => -1, 9 => 0},
      8 => %{0 => 0, 1 => -1, 2 => 0, 3 => -1, 4 => 0, 5 => -1, 6 => 0, 7 => -1, 8 => 0, 9 => -1},
      9 => %{0 => -1, 1 => 0, 2 => -1, 3 => 0, 4 => -1, 5 => 0, 6 => -1, 7 => 0, 8 => -1, 9 => 0}
    }
  end

  # x: x coordinate of board matrix
  # y: y coordinate of board matrix
  # value: value to be put in board matrix at coordinates x, y
  # Note: works in iex if pass board as parameter
  def update_board(x, y, value) do
    board = put_in(board[x][y], value)
  end
end
