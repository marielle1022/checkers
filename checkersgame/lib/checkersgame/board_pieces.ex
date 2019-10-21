# TODO: check if this is better -- if so, rename file to board.ex so outer module name works

defmodule Checkersgame.Board_pieces do
  # Note: Is this alias only usable within this module?
  # Question: Should Piece module be nexted within this?
  alias Checkersgame.Board_pieces, as: Board

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

  defmodule Checkersgame.Piece do
    # Note: Is this alias only usable within this module?
    # Question: Should Piece module be nexted within Board?
    alias Checkersgame.Piece, as: Piece

    # TODO: figure out how state is being saved
    # TODO: see if functions can be cleaned up to take in fewer parameters
    # Reason there are so many parameters -- so can be used for multiple functions
    # TODO: see if cases syntax are correct (autoindent offf)
    # TODO: Decide whether starting x, y should pe passed in instead of finding it using piece so that
    #   functions can be used during BFS for multiple jumps
    # TODO: figure out whether "team/rank" work as atoms

    def new do
      %{
        rank: :normal,
        team: :dark,
        location_x: 0,
        location_y: 0
      }
    end

    def check_valid(whole_board, piece, x, y) do
      case {piece.team, Board.get_value(whole_board, x, y)} do
        {:dark, 0} -> check_dark(whole_board, piece, x, y, 1)
        {:light, 0} -> check_light(whole_board, piece, x, y, 2)
        # This means that the square clicked is light or occupied
        _ -> false
      end
    end

    # Update both the origianl location and the location moved to
    def update_piece_board(
          input_board,
          original_x,
          original_y,
          new_x,
          new_y,
          new_value,
          input_piece
        ) do
      Board.update_board(input_board, original_x, original_y, 0)
      Board.update_board(input_board, new_x, new_y, new_value)
      input_piece |> Map.put(:location_x, new_x)
      input_piece |> Map.put(:location_y, new_y)
    end

    # Dark pieces start at the top
    # Dark pieces are symbolized in the matrix with value 1
    # The (x, y) input represent the location that has been clicked.
    # This is only being called if the value for the clicked square in the matrix is 0.
    def check_dark(whole_board, dark_piece, x, y, new_value) do
      # Store original values for starting x, y of piece
      original_x = dark_piece.location_x
      original_y = dark_piece.location_y

      case {x, y} do
        {a, b} when a == original_x + 1 and b == original_y + 1 ->
          update_piece_board(whole_board, original_x, original_y, x, y, new_value, dark_piece)

        {a, b} when a == original_x + 1 and b == original_y - 1 ->
          update_piece_board(whole_board, original_x, original_y, x, y, new_value, dark_piece)

        {a, b} when a == original_x + 2 and b == original_y + 2 ->
          # if (Board.get_value(whole_board, original_x + 1, original_y + 1) == ) do

          "Do something"

        # Send to function checking valid 1 move jumps

        {a, b} when a == original_x + 2 and b == original_y + 2 ->
          "Do something"

        # Send to function checking valid 1 move jumps

        _ ->
          "Do something"
          # With any other location, send to function checking valid >1 move jumps
      end
    end

    # Light pieces start at the bottom
    # Light pieces are symbolized in the matrix with value 2
    # The (x, y) input represent the location that has been clicked.
    # This is only being called if the value for the clicked square in the matrix is 0.
    def check_light(whole_board, light_piece, x, y, new_value) do
      # Store original values for starting x, y of piece
      original_x = light_piece.location_x
      original_y = light_piece.location_y

      case {x, y} do
        {a, b} when a == original_x - 1 and b == original_y - 1 ->
          update_piece_board(whole_board, original_x, original_y, x, y, new_value, light_piece)

        {a, b} when a == original_x - 1 and b == original_y + 1 ->
          update_piece_board(whole_board, original_x, original_y, x, y, new_value, light_piece)

        {a, b} when a == original_x - 2 and b == original_y - 2 ->
          "Do something"

        # Send to function checking valid 1 move jumps

        {a, b} when a == original_x - 2 and b == original_y + 2 ->
          "Do something"

        # Send to function checking valid 1 move jumps

        _ ->
          "Do something"
          # With any other location, send to function checking valid >1 move jumps
      end
    end

    # This checks intermediary square
    def check_dark_single_jump(whole_board, dark_piece, x, y, new_value) do
      # Store original values for starting x, y of piece
      original_x = dark_piece.location_x
      original_y = dark_piece.location_y
      team_piece = dark_piece.team

      case {team_piece, x, y} do
        {:dark, a, b} when a == original_x + 2 and b == original_y + 2 ->
          if Board.get_value(whole_board, original_x + 1, original_y + 1) == 2 do
            update_piece_board(
              whole_board,
              original_x,
              original_y,
              original_x + 2,
              original_y + 2,
              1,
              dark_piece
            )

            Board.update_board(whole_board, original_x + 1, original_y + 1, 0)
            # add one to score for dark team
            # INSTEAD -- subtract one token from total number of light tokens
            Board.update_score(whole_board, :light)
          else
            # This jump is not valid
            false
          end

        {:dark, a, b} when a == original_x + 2 and b == original_y - 2 ->
          if Board.get_value(whole_board, original_x + 1, original_y - 1) == 2 do
            update_piece_board(
              whole_board,
              original_x,
              original_y,
              original_x + 2,
              original_y - 2,
              1,
              dark_piece
            )

            Board.update_board(whole_board, original_x + 1, original_y - 1, 0)
            Board.update_score(whole_board, :light)
          else
            # This jump is not valid
            false
          end

        # Used for light kings
        {:light, a, b} when a == original_x + 2 and b == original_y + 2 ->
          if Board.get_value(whole_board, original_x + 1, original_y + 1) == 1 do
            update_piece_board(
              whole_board,
              original_x,
              original_y,
              original_x + 2,
              original_y + 2,
              2,
              dark_piece
            )

            Board.update_board(whole_board, original_x + 1, original_y + 1, 0)
            Board.update_score(whole_board, :dark)
          else
            # This jump is not valid
            false
          end

        {:light, a, b} when a == original_x + 2 and b == original_y - 2 ->
          if Board.get_value(whole_board, original_x + 1, original_y - 1) == 1 do
            update_piece_board(
              whole_board,
              original_x,
              original_y,
              original_x + 2,
              original_y - 2,
              2,
              dark_piece
            )

            Board.update_board(whole_board, original_x + 1, original_y - 1, 0)
            # add one to score for LIGHT team
            Board.update_score(whole_board, :dark)
          else
            # This jump is not valid
            false
          end
      end
    end

    # This checks intermediary square
    def check_light_single_jump(whole_board, light_piece, x, y, new_value) do
      # Store original values for starting x, y of piece
      original_x = light_piece.location_x
      original_y = light_piece.location_y
      team_piece = light_piece.team

      case {team_piece, x, y} do
        {:light, a, b} when a == original_x - 2 and b == original_y - 2 ->
          if Board.get_value(whole_board, original_x - 1, original_y - 1) == 1 do
            update_piece_board(
              whole_board,
              original_x,
              original_y,
              original_x - 2,
              original_y - 2,
              2,
              light_piece
            )

            # This removes the intermediary piece from the matrix -- BUT How to remove the piece itself?
            # Does the matrix update the buttons?
            Board.update_board(whole_board, original_x - 1, original_y - 1, 0)
            # add one to score for dark team
            Board.update_score(whole_board, :dark)
          else
            # This jump is not valid
            false
          end

        {:light, a, b} when a == original_x - 2 and b == original_y + 2 ->
          if Board.get_value(whole_board, original_x - 1, original_y + 1) == 1 do
            update_piece_board(
              whole_board,
              original_x,
              original_y,
              original_x - 2,
              original_y + 2,
              2,
              light_piece
            )

            Board.update_board(whole_board, original_x - 1, original_y + 1, 0)
            # add one to score for dark team
            Board.update_score(whole_board, :dark)
          else
            # This jump is not valid
            false
          end

        # Used for dark kings
        {:dark, a, b} when a == original_x - 2 and b == original_y - 2 ->
          if Board.get_value(whole_board, original_x - 1, original_y - 1) == 2 do
            update_piece_board(
              whole_board,
              original_x,
              original_y,
              original_x - 2,
              original_y - 2,
              1,
              light_piece
            )

            # This removes the intermediary piece from the matrix -- BUT How to remove the piece itself?
            # Does the matrix update the buttons?
            Board.update_board(whole_board, original_x - 1, original_y - 1, 0)
            # add one to score for dark team
            Board.update_score(whole_board, :light)
          else
            # This jump is not valid
            false
          end

        {:dark, a, b} when a == original_x - 2 and b == original_y + 2 ->
          if Board.get_value(whole_board, original_x - 1, original_y + 1) == 2 do
            update_piece_board(
              whole_board,
              original_x,
              original_y,
              original_x - 2,
              original_y + 2,
              1,
              light_piece
            )

            Board.update_board(whole_board, original_x - 1, original_y + 1, 0)
            # add one to score for dark team
            Board.update_score(whole_board, :light)
          else
            # This jump is not valid
            false
          end
      end
    end
  end
end
