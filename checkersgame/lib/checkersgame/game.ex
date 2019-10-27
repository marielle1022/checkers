defmodule Checkersgame.Game do
  alias Checkersgame.Game, as: Game
  import Checkersgame.Piece

  def new do
    %{
      # set up matrix -- this is the layout for the whole board
      board_matrix: create_board(),
      move: [],
      check_move: false,
      list_dark: create_dark_pieces(),
      list_light: create_light_pieces(),
      total_dark: 20,
      total_light: 20
    }
  end

  def client_view(game) do
    %{
      board_matrix: game.board_matrix,
      move: [],
      list_dark: game.list_dark,
      list_light: game.list_light,
      total_dark: game.total_dark,
      total_light: game.total_light
    }
  end

  def click(game, ll) do
    if Enum.at(ll, 2) == 1 do
      piece = Map.get(game.list_dark, [Enum.at(ll, 0), Enum.at(ll, 1)])
      Checkersgame.Piece.start_move_check_king(game, piece, Enum.at(ll, 3), Enum.at(ll, 4))
    else
      piece = Map.get(game.list_light, [Enum.at(ll, 0), Enum.at(ll, 1)])
      Checkersgame.Piece.start_move_check_king(game, piece, Enum.at(ll, 3), Enum.at(ll, 4))
    end
  end

  # To create nested map, used
  # https://blog.danielberkompas.com/2016/04/23/multidimensional-arrays-in-elixir/
  def create_board do
    # Dark squares (the only ones being used) will be represented with 0
    # Light squares (which won't be used) will be represented with -1
    # Dark pieces are represented with value 1 and start at the top
    # Light pieces are represented with value 2 and start at the bottom
    %{
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
  def update_board(game, x, y, value) do
    game = put_in(game.board_matrix[x][y], value)
  end

  # Get value of game board
  def get_value(game, x, y) do
    game.board_matrix[x][y]
  end

  # Update value of number of tokens
  def update_score(game, team) do
    case team do
      :dark ->
        game = Map.put(game, :total_dark, game.total_dark - 1)

      :light ->
        game = Map.put(game, :total_light, game.total_light - 1)
    end
  end
end
