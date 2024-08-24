module Update exposing (Msg (..), update)

import State exposing (State)
import State.Delta exposing (Delta, gradient, step)

type Msg
  = AdvanceGameClock

update : Msg -> (Delta, State) -> ((Delta, State), Cmd Msg)
update msg (_, model) =
  case msg of
    AdvanceGameClock ->
      let
        patch =
          gradient model
      in
        ((patch, step patch model), Cmd.none)
