module View exposing (view)

import State exposing (State)
import Html exposing (..)
import Html.Events exposing (onClick)
import Update exposing (Event (..))
import State.Delta exposing (Delta)

view : Delta -> State -> Html Event
view delta state =
    let
        fish =
            String.fromFloat state.fish

        money =
            String.fromFloat state.money
    in
    div []
        [ button [ onClick CatchFish ]
            [ text "Catch fish"
            ]
        , button [ onClick SellFish ]
            [ text "Sell fish"
            ]
        , p [] [ text ("You have " ++ fish ++ "kg of fish.") ]
        , p [] [ text ("You have $" ++ money ++ ".") ]
        ]
