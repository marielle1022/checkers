defmodule Checkersgame.Game do
  # Note: Is this alias only usable within this module?
  # Question: Should Piece module be nexted within this?
  alias Checkersgame.Game, as: Game
  import Checkersgame.Piece

  # NB: use agents to implement states?!

  # TODO: ANYTIME ANYTHING is done, send it to backupagent

  def new do
    %{
      # set up matrix
      # Question: how to define this so it can be updated at each move? Is it possible?
      board_matrix: create_board(),
      move: [],
      check_move: false,
      list_dark: create_dark_pieces(),
      list_light: create_light_pieces(),
      total_dark: 20,
      total_light: 20
    }
  end

  # Gen Server - Has observers, game state, etc (in map)
  # In game state - Have map w/ state
  # in board - store references to pieces
  def client_view(game) do
    # Need to call start_move_check_king(game, piece, x, y) there
    # First need to take in click params, get piece matching params
    %{
      board_matrix: game.board_matrix,
      move: [],
      check_move:
        start_move(
          game,
          Enum.at(game.move, 0),
          Enum.at(game.move, 1),
          Enum.at(game.move, 2),
          Enum.at(game.move, 3),
          Enum.at(game.move, 4)
        ),
      # check_move: start_move(game, move[1], move[2], move[3], move[4], move[5]),
      list_dark: game.list_dark,
      list_light: game.list_light,
      total_dark: game.total_dark,
      total_light: game.total_light
    }
  end

  # def client_view(game, name) do
  #   client_board = game.board_matrix
  #   current_dark = game.total_dark
  #   current_light = game.total_light
  #   list_dark = game.list_dark
  #   list_light = game.list_light
  #
  #   %{
  #     current_board: client_board,
  #     total_dark: current_dark,
  #     total_light: current_light,
  #     dark_pieces: list_dark,
  #     light_pieces: list_light
  #   }
  # end

  def start_move(game, starting_x, starting_y, team, ending_x, ending_y) do
    if team === 1 do
      piece = game.list_dark.fetch([starting_x, starting_y])
      # Checkersgame.Piece.start_move_check_king(game, piece, ending_x, ending_y)
    else
      # piece = game.list_light.fetch([starting_x, starting_y])
      # Checkersgame.Piece.start_move_check_king(game, piece, ending_x, ending_y)
      "bye"
    end

    # Checkersgame.Piece.start_move_check_king(game, piece, ending_x, ending_y)
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
  # Note: works in iex if pass board as parameter, but doesn't save
  # NB: set up so directly modifies state board? change name to game
  def update_board(game, x, y, value) do
    new_board = put_in(game.board_matrix[x][y], value)
    game |> Map.put(:board_matrix, new_board)
  end

  # Get value of game board
  def get_value(game, x, y) do
    game.board_matrix[x][y]
  end

  # Update value of number of tokens
  def update_score(game, team) do
    case team do
      :dark -> game |> Map.put(:total_dark, game[:total_dark] - 1)
      :light -> game |> Map.put(:total_light, game[:total_light] - 1)
    end
  end

  # After a change has been made to a piece's location,
  # removes the key:value pair with the old location
  # and adds the key:value pair for the new one
  def update_piece_list(game, team, piece, new_x, new_y) do
    case team do
      :dark ->
        game.list_dark
        |> Map.put([new_x, new_y], game.list_dark.get(piece))
        |> Map.delete(piece)

      # Question: Does |> mean Map output from put() is input for first param in Map.delete?
      # With this, saying function Map.delete/3 is undefined/private
      # |> Map.delete(game.list_dark, piece)
      # Question: same issue with above Map.put

      :light ->
        game.list_light
        |> Map.put([new_x, new_y], game.list_light.get(piece))
        |> Map.delete(piece)

        # Question: Does |> mean Map output from put() is input for first param in Map.delete?
        # With this, saying function Map.delete/3 is undefined/private
        # |> Map.delete(game.list_light, piece)
    end
  end
end
