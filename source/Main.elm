module Main exposing (main)

import Browser exposing (element)
import Html exposing (text)
import State exposing (State)
import State.Delta exposing (Delta, gradient)
import Time
import Update exposing (Msg(..), update)


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
                    money =
                        String.fromFloat state.money
                in
                text ("You have $" ++ money ++ ".")
        , update =
            update
        , subscriptions =
            \_ ->
                Time.every 1000 <|
                    \_ ->
                        Update.AdvanceGameClock
        }
