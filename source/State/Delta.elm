module State.Delta exposing (Delta, gradient, step)

import State exposing (State)


type alias Delta =
    { money : Float
    , fish : Float
    }


gradient : State -> Delta
gradient state =
    { money =
        0
    , fish =
        0
    }


step : Delta -> State -> State
step delta state =
    { money =
        state.money + delta.money
    , fish =
        state.fish + delta.fish
    }
