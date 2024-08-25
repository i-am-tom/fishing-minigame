module State.Delta exposing (Delta, gradient, step)

import Constants
import State exposing (State)


type alias Delta =
    { money : Float
    , resources :
        { fish : Float
        }
    , staff :
        { fishers : Float
        }
    }


gradient : State -> Delta
gradient state =
    let
        updatedFish =
            state.staff.fishers * Constants.fishPerTrip

        updatedMoney =
            -1 * state.staff.fishers * Constants.fisherWages
    in
    { money =
        if state.money + updatedMoney < 0 then
            -state.money

        else
            updatedMoney
    , resources =
        { fish =
            if updatedMoney + state.money > 0 then
                updatedFish

            else
                0
        }
    , staff =
        { fishers =
            if state.money + updatedMoney < 0 then
                -state.staff.fishers

            else
                0
        }
    }


step : Delta -> State -> State
step delta state =
    { money =
        state.money + delta.money
    , resources =
        { fish = state.resources.fish + delta.resources.fish
        }
    , staff =
        { fishers = state.staff.fishers + delta.staff.fishers
        }
    }
