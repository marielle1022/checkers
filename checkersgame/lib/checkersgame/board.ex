defmodule Checkersgame.Board do
  # Note: Is this alias only usable within this module?
  # Question: Should Piece module be nexted within this?
  alias Checkersgame.Board, as: Board

  # NB: use agents to implement states?!

  def new do
    %{
      # set up matrix
      # Question: how to define this so it can be updated at each move? Is it possible?
      game_board: create_board(),
      num_dark: 20,
      num_light: 20
    }
  end

  # def client_view(board) do
  #  board.game_board

  # end

  # To create nested map, used
  # https://blog.danielberkompas.com/2016/04/23/multidimensional-arrays-in-elixir/
  def create_board do
    # Dark squares (the only ones being used) will be represented with 0
    # Light squares (which won't be used) will be represented with -1
    # Dark pieces are represented with value 1 and start at the top
    # Light pieces are represented with value 2 and start at the bottom
    starting_board = %{
      0 => %{0 => 1, 1 => -1, 2 => 1, 3 => -1, 4 => 1, 5 => -1, 6 => 1, 7 => -1, 8 => 1, 9 => -1},
      1 => %{0 => -1, 1 => 1, 2 => -1, 3 => 1, 4 => -1, 5 => 1, 6 => -1, 7 => 1, 8 => -1, 9 => 1},
      2 => %{0 => 1, 1 => -1, 2 => 1, 3 => -1, 4 => 1, 5 => -1, 6 => 1, 7 => -1, 8 => 1, 9 => -1},
      3 => %{0 => -1, 1 => 1, 2 => -1, 3 => 1, 4 => -1, 5 => 1, 6 => -1, 7 => 1, 8 => -1, 9 => 1},
      4 => %{0 => 0, 1 => -1, 2 => 0, 3 => -1, 4 => 0, 5 => -1, 6 => 0, 7 => -1, 8 => 0, 9 => -1},
      5 => %{0 => -1, 1 => 0, 2 => -1, 3 => 0, 4 => -1, 5 => 0, 6 => -1, 7 => 0, 8 => -1, 9 => 0},
      6 => %{0 => 2, 1 => -1, 2 => 2, 3 => -1, 4 => 2, 5 => -1, 6 => 2, 7 => -1, 8 => 2, 9 => -1},
      7 => %{0 => -1, 1 => 2, 2 => -1, 3 => 2, 4 => -1, 5 => 2, 6 => -1, 7 => 2, 8 => -1, 9 => 2},
      8 => %{0 => 2, 1 => -1, 2 => 2, 3 => -1, 4 => 2, 5 => -1, 6 => 2, 7 => -1, 8 => 2, 9 => -1},
      9 => %{0 => -1, 1 => 2, 2 => -1, 3 => 2, 4 => -1, 5 => 2, 6 => -1, 7 => 2, 8 => -1, 9 => 2}
    }
  end

  # x: x coordinate of board matrix
  # y: y coordinate of board matrix
  # value: value to be put in board matrix at coordinates x, y
  # Note: works in iex if pass board as parameter, but doesn't save
  def update_board(input_board, x, y, value) do
    new_board = put_in(input_board.game_board[x][y], value)
    input_board |> Map.put(:game_board, new_board)
  end

  # Get value of game board
  def get_value(input_board, x, y) do
    input_board.game_board[x][y]
  end

  # Update value of number of tokens
  def update_score(input_board, team) do
    case team do
      :dark -> input_board |> Map.put(:num_dark, input_board[:num_dark] - 1)
      :light -> input_board |> Map.put(:num_light, input_board[:num_light] - 1)
    end
  end
end
