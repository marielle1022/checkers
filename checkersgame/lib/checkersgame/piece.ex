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

  # TODO: ANYTIME ANYTHING is done, send it to backupagent

  def new(team, x, y) do
    %{
      rank: :normal,
      team: team,
      location_x: x,
      location_y: y
    }
  end

  def start_move_check_king(game, piece, x, y) do
    if check_valid(game, piece, x, y) != false do
      tempRank = piece.rank
      tempTeam = piece.team

      case {tempRank, tempTeam, x} do
        {:normal, :dark, 9} when tempRank == :normal and tempTeam == :dark ->
          "make king"

        #  make_king(game, piece)

        {:normal, :light, 0} when tempRank == :normal and tempTeam == :light ->
          "make king"

        #  make_king(game, piece)

        _ ->
          "No change to rank"

          # if piece.rank(is(:normal) and piece.team(is(:dark and x == 9))) do
          #  piece.rank = :king
          # else
          #  if(piece.rank(is(:normal) and piece.team(is(:light and x == 0))))
          #  piece.rank = :king
      end
    end
  end

  # def make_king(_game, piece) do
  #   Map.put(piece, rank, :king)
  # end

  def check_valid(game, piece, x, y) do
    case {piece.team, Checkersgame.Game.get_value(game, x, y)} do
      {:dark, 0} -> check_dark(game, piece, x, y, 1)
      {:light, 0} -> check_light(game, piece, x, y, 2)
      # This means that the square clicked is light or occupied
      _ -> false
    end
  end

  # Update both the origianl location and the location moved to
  def update_piece_board(
        game,
        original_x,
        original_y,
        new_x,
        new_y,
        new_value,
        input_piece
      ) do
    Checkersgame.Game.update_board(game, original_x, original_y, 0)
    Checkersgame.Game.update_board(game, new_x, new_y, new_value)
    input_piece |> Map.put(:location_x, new_x)
    input_piece |> Map.put(:location_y, new_y)
  end

  # Dark pieces start at the top
  # Dark pieces are symbolized in the matrix with value 1
  # The (x, y) input represent the location that has been clicked.
  # This is only being called if the value for the clicked square in the matrix is 0.
  def check_dark(game, dark_piece, x, y, new_value) do
    # Store original values for starting x, y of piece
    original_x = dark_piece.location_x
    original_y = dark_piece.location_y

    case {x, y} do
      {a, b} when a == original_x + 1 and b == original_y + 1 ->
        update_piece_board(game, original_x, original_y, x, y, new_value, dark_piece)

      {a, b} when a == original_x + 1 and b == original_y - 1 ->
        update_piece_board(game, original_x, original_y, x, y, new_value, dark_piece)

      {a, b} when a == original_x + 2 and b == original_y + 2 ->
        check_dark_single_jump(game, dark_piece, x, y)

      # if (Checkersgame.Game.get_value(game, original_x + 1, original_y + 1) == ) do

      # Send to function checking valid 1 move jumps

      {a, b} when a == original_x + 2 and b == original_y - 2 ->
        check_dark_single_jump(game, dark_piece, x, y)

      # Send to function checking valid 1 move jumps

      _ ->
        "Send to check >1 move jumps"
        # With any other location, send to function checking valid >1 move jumps
    end
  end

  # Light pieces start at the bottom
  # Light pieces are symbolized in the matrix with value 2
  # The (x, y) input represent the location that has been clicked.
  # This is only being called if the value for the clicked square in the matrix is 0.
  def check_light(game, light_piece, x, y, new_value) do
    # Store original values for starting x, y of piece
    original_x = light_piece.location_x
    original_y = light_piece.location_y

    case {x, y} do
      {a, b} when a == original_x - 1 and b == original_y - 1 ->
        update_piece_board(game, original_x, original_y, x, y, new_value, light_piece)

      {a, b} when a == original_x - 1 and b == original_y + 1 ->
        update_piece_board(game, original_x, original_y, x, y, new_value, light_piece)

      {a, b} when a == original_x - 2 and b == original_y - 2 ->
        check_light_single_jump(game, light_piece, x, y)

      # Send to function checking valid 1 move jumps

      {a, b} when a == original_x - 2 and b == original_y + 2 ->
        check_light_single_jump(game, light_piece, x, y)

      # Send to function checking valid 1 move jumps

      _ ->
        "Check valid >1 move jump"
        # With any other location, send to function checking valid >1 move jumps
    end
  end

  # This checks intermediary square
  def check_dark_single_jump(game, dark_piece, x, y) do
    # Store original values for starting x, y of piece
    original_x = dark_piece.location_x
    original_y = dark_piece.location_y
    team_piece = dark_piece.team

    case {team_piece, x, y} do
      {:dark, a, b} when a == original_x + 2 and b == original_y + 2 ->
        if Checkersgame.Game.get_value(game, original_x + 1, original_y + 1) == 2 do
          update_piece_board(
            game,
            original_x,
            original_y,
            original_x + 2,
            original_y + 2,
            1,
            dark_piece
          )

          Checkersgame.Game.update_board(game, original_x + 1, original_y + 1, 0)
          # add one to score for dark team
          # INSTEAD -- subtract one token from total number of light tokens
          Checkersgame.Game.update_score(game, :light)
        else
          # This jump is not valid
          false
        end

      {:dark, a, b} when a == original_x + 2 and b == original_y - 2 ->
        if Checkersgame.Game.get_value(game, original_x + 1, original_y - 1) == 2 do
          update_piece_board(
            game,
            original_x,
            original_y,
            original_x + 2,
            original_y - 2,
            1,
            dark_piece
          )

          Checkersgame.Game.update_board(game, original_x + 1, original_y - 1, 0)
          Checkersgame.Game.update_score(game, :light)
        else
          # This jump is not valid
          false
        end

      # Used for light kings
      {:light, a, b} when a == original_x + 2 and b == original_y + 2 ->
        if Checkersgame.Game.get_value(game, original_x + 1, original_y + 1) == 1 do
          update_piece_board(
            game,
            original_x,
            original_y,
            original_x + 2,
            original_y + 2,
            2,
            dark_piece
          )

          Checkersgame.Game.update_board(game, original_x + 1, original_y + 1, 0)
          Checkersgame.Game.update_score(game, :dark)
        else
          # This jump is not valid
          false
        end

      {:light, a, b} when a == original_x + 2 and b == original_y - 2 ->
        if Checkersgame.Game.get_value(game, original_x + 1, original_y - 1) == 1 do
          update_piece_board(
            game,
            original_x,
            original_y,
            original_x + 2,
            original_y - 2,
            2,
            dark_piece
          )

          Checkersgame.Game.update_board(game, original_x + 1, original_y - 1, 0)
          # add one to score for LIGHT team
          Checkersgame.Game.update_score(game, :dark)
        else
          # This jump is not valid
          false
        end
    end
  end

  # This checks intermediary square
  def check_light_single_jump(game, light_piece, x, y) do
    # Store original values for starting x, y of piece
    original_x = light_piece.location_x
    original_y = light_piece.location_y
    team_piece = light_piece.team

    case {team_piece, x, y} do
      {:light, a, b} when a == original_x - 2 and b == original_y - 2 ->
        if Checkersgame.Game.get_value(game, original_x - 1, original_y - 1) == 1 do
          update_piece_board(
            game,
            original_x,
            original_y,
            original_x - 2,
            original_y - 2,
            2,
            light_piece
          )

          # This removes the intermediary piece from the matrix -- BUT How to remove the piece itself?
          # Does the matrix update the buttons?
          Checkersgame.Game.update_board(game, original_x - 1, original_y - 1, 0)
          # add one to score for dark team
          Checkersgame.Game.update_score(game, :dark)
        else
          # This jump is not valid
          false
        end

      {:light, a, b} when a == original_x - 2 and b == original_y + 2 ->
        if Checkersgame.Game.get_value(game, original_x - 1, original_y + 1) == 1 do
          update_piece_board(
            game,
            original_x,
            original_y,
            original_x - 2,
            original_y + 2,
            2,
            light_piece
          )

          Checkersgame.Game.update_board(game, original_x - 1, original_y + 1, 0)
          # add one to score for dark team
          Checkersgame.Game.update_score(game, :dark)
        else
          # This jump is not valid
          false
        end

      # Used for dark kings
      {:dark, a, b} when a == original_x - 2 and b == original_y - 2 ->
        if Checkersgame.Game.get_value(game, original_x - 1, original_y - 1) == 2 do
          update_piece_board(
            game,
            original_x,
            original_y,
            original_x - 2,
            original_y - 2,
            1,
            light_piece
          )

          # This removes the intermediary piece from the matrix -- BUT How to remove the piece itself?
          # Does the matrix update the buttons?
          Checkersgame.Game.update_board(game, original_x - 1, original_y - 1, 0)
          # add one to score for dark team
          Checkersgame.Game.update_score(game, :light)
        else
          # This jump is not valid
          false
        end

      {:dark, a, b} when a == original_x - 2 and b == original_y + 2 ->
        if Checkersgame.Game.get_value(game, original_x - 1, original_y + 1) == 2 do
          update_piece_board(
            game,
            original_x,
            original_y,
            original_x - 2,
            original_y + 2,
            1,
            light_piece
          )

          Checkersgame.Game.update_board(game, original_x - 1, original_y + 1, 0)
          # add one to score for dark team
          Checkersgame.Game.update_score(game, :light)
        else
          # This jump is not valid
          false
        end
    end
  end
end
