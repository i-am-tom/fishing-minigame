module Main exposing (main)

import Browser exposing (element)
import Html exposing (..)
import State exposing (State)
import Time
import Update exposing (Msg (..))

main : Program () State Msg
main =
  element
    { init = \_ ->
        ( State.initial
        , Cmd.none
        )

    , view = \state ->
        let
          money = String.fromFloat state.money
        in
          text ("You have $" ++ money ++ ".")

    , update = \_ model ->
        ( model
        , Cmd.none
        )

    , subscriptions = \_ ->
        Time.every 1000 <| \_ ->
          Update.AdvanceGameClock
    }
