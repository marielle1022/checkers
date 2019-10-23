defmodule Checkersgame.Game do
  # Note: Is this alias only usable within this module?
  # Question: Should Piece module be nexted within this?
  alias Checkersgame.Game, as: Game
  import Checkersgame.Piece

  # NB: use agents to implement states?!

  def new do
    %{
      # set up matrix
      # Question: how to define this so it can be updated at each move? Is it possible?
      game_board: create_board(),
      num_dark: 20,
      num_light: 20,
      all_dark_pieces: create_dark_pieces,
      all_light_pieces: create_light_pieces
    }
  end

  # Gen Server - Has observers, game state, etc (in map)
  # In game state - Have map w/ state
  # in board - store references to pieces

  def client_view(game, user) do
    client_board = game.game_board
    current_dark = game.num_dark
    current_light = game.num_light
    list_dark = game.all_dark_pieces
    list_light = game.all_light_pieces

    %{
      current_board: client_board,
      num_dark: current_dark,
      num_light: current_light,
      dark_pieces: list_dark,
      light_pieces: list_light
    }
  end

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

  def create_dark_pieces do
    %{
      [0, 0] => Checkersgame.Piece.new(:dark, 0, 0),
      [0, 2] => Checkersgame.Piece.new(:dark, 0, 2),
      [0, 4] => Checkersgame.Piece.new(:dark, 0, 4),
      [0, 6] => Checkersgame.Piece.new(:dark, 0, 6),
      [0, 8] => Checkersgame.Piece.new(:dark, 0, 8),
      [1, 1] => Checkersgame.Piece.new(:dark, 1, 1),
      [1, 3] => Checkersgame.Piece.new(:dark, 1, 3),
      [1, 5] => Checkersgame.Piece.new(:dark, 1, 5),
      [1, 7] => Checkersgame.Piece.new(:dark, 1, 7),
      [1, 9] => Checkersgame.Piece.new(:dark, 1, 9),
      [2, 0] => Checkersgame.Piece.new(:dark, 2, 0),
      [2, 2] => Checkersgame.Piece.new(:dark, 2, 2),
      [2, 4] => Checkersgame.Piece.new(:dark, 2, 4),
      [2, 6] => Checkersgame.Piece.new(:dark, 2, 6),
      [2, 8] => Checkersgame.Piece.new(:dark, 2, 8),
      [3, 1] => Checkersgame.Piece.new(:dark, 3, 1),
      [3, 3] => Checkersgame.Piece.new(:dark, 3, 3),
      [3, 5] => Checkersgame.Piece.new(:dark, 3, 5),
      [3, 7] => Checkersgame.Piece.new(:dark, 3, 7),
      [3, 9] => Checkersgame.Piece.new(:dark, 3, 9)
    }
  end

  def create_light_pieces do
    %{
      [6, 0] => Checkersgame.Piece.new(:light, 6, 0),
      [6, 2] => Checkersgame.Piece.new(:light, 6, 2),
      [6, 4] => Checkersgame.Piece.new(:light, 6, 4),
      [6, 6] => Checkersgame.Piece.new(:light, 6, 6),
      [6, 8] => Checkersgame.Piece.new(:light, 6, 8),
      [7, 1] => Checkersgame.Piece.new(:light, 7, 1),
      [7, 3] => Checkersgame.Piece.new(:light, 7, 3),
      [7, 5] => Checkersgame.Piece.new(:light, 7, 5),
      [7, 7] => Checkersgame.Piece.new(:light, 7, 7),
      [7, 9] => Checkersgame.Piece.new(:light, 7, 9),
      [8, 0] => Checkersgame.Piece.new(:light, 8, 0),
      [8, 2] => Checkersgame.Piece.new(:light, 8, 2),
      [8, 4] => Checkersgame.Piece.new(:light, 8, 4),
      [8, 6] => Checkersgame.Piece.new(:light, 8, 6),
      [8, 8] => Checkersgame.Piece.new(:light, 8, 8),
      [9, 1] => Checkersgame.Piece.new(:light, 9, 1),
      [9, 3] => Checkersgame.Piece.new(:light, 9, 3),
      [9, 5] => Checkersgame.Piece.new(:light, 9, 5),
      [9, 7] => Checkersgame.Piece.new(:light, 9, 7),
      [9, 9] => Checkersgame.Piece.new(:light, 9, 9)
    }
  end

  # x: x coordinate of board matrix
  # y: y coordinate of board matrix
  # value: value to be put in board matrix at coordinates x, y
  # Note: works in iex if pass board as parameter, but doesn't save
  # NB: set up so directly modifies state board? change name to game
  def update_board(game, x, y, value) do
    new_board = put_in(game.game_board[x][y], value)
    game |> Map.put(:game_board, new_board)
  end

  # Get value of game board
  def get_value(game, x, y) do
    game.game_board[x][y]
  end

  # Update value of number of tokens
  def update_score(game, team) do
    case team do
      :dark -> game |> Map.put(:num_dark, game[:num_dark] - 1)
      :light -> game |> Map.put(:num_light, game[:num_light] - 1)
    end
  end
end
