module State.Delta exposing (Delta, gradient, step)

import State exposing (State)


type alias Delta =
    { money : Float
    , resources :
        { fish : Float
        }
    }


gradient : State -> Delta
gradient state =
    { money =
        0
    , resources =
        { fish = 0 }
    }


step : Delta -> State -> State
step delta state =
    { money =
        state.money + delta.money
    , resources =
        { fish = state.resources.fish + delta.resources.fish
        }
    }
