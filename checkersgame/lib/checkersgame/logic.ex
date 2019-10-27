defmodule Checkersgame.Logic do
  alias Checkersgame.Logic, as: Logic

  def logic_check_valid(game, piece, x, y) do
    case {piece.team, Checkersgame.Game.get_value(game, x, y)} do
      {:dark, 0} ->
        logic_check_dark(game, piece, x, y, 1)

      {:light, 0} ->
        logic_check_light(game, piece, x, y, 2)

      # This means that the square clicked is light or occupied
      _ ->
        false
    end
  end

  # Dark pieces start at the top
  # Dark pieces are symbolized in the matrix with value 1
  # The (x, y) input represent the location that has been clicked.
  # This is only being called if the value for the clicked square in the matrix is 0.
  def logic_check_dark(game, dark_piece, x, y, new_value) do
    # Store original values for starting x, y of piece
    original_x = dark_piece.location_x
    original_y = dark_piece.location_y

    case {x, y} do
      {a, b} when a == original_x + 1 and b == original_y + 1 ->
        true

      {a, b} when a == original_x + 1 and b == original_y - 1 ->
        true

      {a, b} when a == original_x + 2 and b == original_y + 2 ->
        logic_check_dark_single_jump(game, dark_piece, x, y)

      # if (Checkersgame.Game.get_value(game, original_x + 1, original_y + 1) == ) do

      # Send to function checking valid 1 move jumps

      {a, b} when a == original_x + 2 and b == original_y - 2 ->
        logic_check_dark_single_jump(game, dark_piece, x, y)

      # Send to function checking valid 1 move jumps

      _ ->
        false
        # With any other location, send to function checking valid >1 move jumps
    end
  end

  # Light pieces start at the bottom
  # Light pieces are symbolized in the matrix with value 2
  # The (x, y) input represent the location that has been clicked.
  # This is only being called if the value for the clicked square in the matrix is 0.
  def logic_check_light(game, light_piece, x, y, new_value) do
    # Store original values for starting x, y of piece
    original_x = light_piece.location_x
    original_y = light_piece.location_y

    case {x, y} do
      {a, b} when a == original_x - 1 and b == original_y - 1 ->
        true

      {a, b} when a == original_x - 1 and b == original_y + 1 ->
        true

      {a, b} when a == original_x - 2 and b == original_y - 2 ->
        logic_check_light_single_jump(game, light_piece, x, y)

      # Send to function checking valid 1 move jumps

      {a, b} when a == original_x - 2 and b == original_y + 2 ->
        logic_check_light_single_jump(game, light_piece, x, y)

      # Send to function checking valid 1 move jumps

      _ ->
        false
        # With any other location, send to function checking valid >1 move jumps
    end
  end

  # This checks intermediary square
  def logic_check_dark_single_jump(game, dark_piece, x, y) do
    # Store original values for starting x, y of piece
    original_x = dark_piece.location_x
    original_y = dark_piece.location_y
    team_piece = dark_piece.team

    case {team_piece, x, y} do
      {:dark, a, b} when a == original_x + 2 and b == original_y + 2 ->
        if Checkersgame.Game.get_value(game, original_x + 1, original_y + 1) == 2 do
          true
        else
          # This jump is not valid
          false
        end

      {:dark, a, b} when a == original_x + 2 and b == original_y - 2 ->
        if Checkersgame.Game.get_value(game, original_x + 1, original_y - 1) == 2 do
          true
        else
          # This jump is not valid
          false
        end

      # Used for light kings
      {:light, a, b} when a == original_x + 2 and b == original_y + 2 ->
        if Checkersgame.Game.get_value(game, original_x + 1, original_y + 1) == 1 do
          true
        else
          # This jump is not valid
          false
        end

      {:light, a, b} when a == original_x + 2 and b == original_y - 2 ->
        if Checkersgame.Game.get_value(game, original_x + 1, original_y - 1) == 1 do
          # add one to score for LIGHT team
          true
        else
          # This jump is not valid
          false
        end
    end
  end

  # This checks intermediary square
  def logic_check_light_single_jump(game, light_piece, x, y) do
    # Store original values for starting x, y of piece
    original_x = light_piece.location_x
    original_y = light_piece.location_y
    team_piece = light_piece.team

    case {team_piece, x, y} do
      {:light, a, b} when a == original_x - 2 and b == original_y - 2 ->
        if Checkersgame.Game.get_value(game, original_x - 1, original_y - 1) == 1 do
          # add one to score for dark team
          true
        else
          # This jump is not valid
          false
        end

      {:light, a, b} when a == original_x - 2 and b == original_y + 2 ->
        if Checkersgame.Game.get_value(game, original_x - 1, original_y + 1) == 1 do
          # add one to score for dark team
          true
        else
          # This jump is not valid
          false
        end

      # Used for dark kings
      {:dark, a, b} when a == original_x - 2 and b == original_y - 2 ->
        if Checkersgame.Game.get_value(game, original_x - 1, original_y - 1) == 2 do
          # add one to score for dark team
          true
        else
          # This jump is not valid
          false
        end

      {:dark, a, b} when a == original_x - 2 and b == original_y + 2 ->
        if Checkersgame.Game.get_value(game, original_x - 1, original_y + 1) == 2 do
          # add one to score for dark team
          true
        else
          # This jump is not valid
          false
        end
    end
  end
end
