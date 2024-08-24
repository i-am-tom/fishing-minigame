module Main exposing (main)

import Browser exposing (element)
import Html exposing (button, div, p, text)
import Html.Events exposing (onClick)
import State exposing (State)
import State.Delta exposing (Delta, gradient, step)
import Time
import Update exposing (Event(..), update)
import View exposing (view)


type Msg
    = AdvanceGameClock
    | GameEvent Event


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
            \( delta, state ) ->
              Html.map GameEvent <|
                view delta state
        , update =
            \msg ( delta, state ) ->
                case msg of
                    AdvanceGameClock ->
                        let
                            patch =
                                gradient state
                        in
                        ( ( patch, step patch state ), Cmd.none )

                    GameEvent event ->
                        let
                            ( updated, cmd ) =
                                update event state
                        in
                        ( ( delta, updated ), Cmd.map GameEvent cmd )
        , subscriptions =
            \_ ->
                Time.every 1000 (always AdvanceGameClock)
        }
