module Main exposing (main)

import Browser exposing (element)
import Html exposing (button, div, p, text)
import Html.Events exposing (onClick)
import State exposing (State)
import State.Delta exposing (Delta, gradient)
import Time
import Update exposing (Event(..), Msg(..), update)


main : Program () ( Delta, State ) Msg
main =
    element
        { init =
            \_ ->
                ( ( gradient State.initial
                  , State.initial
                  )
                , Cmd.none
                )
        , view =
            \( _, state ) ->
                let
                    fish =
                        String.fromFloat state.fish

                    money =
                        String.fromFloat state.money
                in
                div []
                    [ button [ onClick (GameEvent CatchFish) ]
                        [ text "Catch fish"
                        ]
                    , button [ onClick (GameEvent SellFish) ]
                        [ text "Sell fish"
                        ]
                    , p [] [ text ("You have " ++ fish ++ "kg of fish.") ]
                    , p [] [ text ("You have $" ++ money ++ ".") ]
                    ]
        , update =
            update
        , subscriptions =
            \_ ->
                Time.every 1000 <|
                    \_ ->
                        Update.AdvanceGameClock
        }
