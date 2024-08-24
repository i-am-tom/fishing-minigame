module Update exposing (Event(..), Msg(..), update)

import AssocList as Dict exposing (Dict)
import Random exposing (Generator)
import State exposing (State)
import State.Delta exposing (Delta, gradient, step)


type Msg
    = NoOp
    | AdvanceGameClock
    | Probabilities (Dict Msg Float)
    | GameEvent Event


type Event
    = CatchFish
    | SellFish


update : Msg -> ( Delta, State ) -> ( ( Delta, State ), Cmd Msg )
update msg ( delta, model ) =
    case msg of
        NoOp ->
            ( ( delta, model ), Cmd.none )

        AdvanceGameClock ->
            let
                patch =
                    gradient model
            in
            ( ( patch, step patch model ), Cmd.none )

        Probabilities entries ->
            let
                generateEntry : ( Msg, Float ) -> Cmd (Maybe Msg)
                generateEntry ( key, threshold ) =
                    Random.float 0 1
                        |> Random.generate
                            (\roll ->
                                if roll < threshold then
                                    Just key

                                else
                                    Nothing
                            )

                results : Cmd Msg
                results =
                    entries
                        |> Dict.toList
                        |> List.map generateEntry
                        |> Cmd.batch
                        |> Cmd.map (Maybe.withDefault NoOp)
            in
            ( ( delta, model ), results )

        GameEvent event ->
            case event of
                CatchFish ->
                    ( ( delta, { model | fish = model.fish + 1 } ), Cmd.none )

                SellFish ->
                    ( ( delta, { model | fish = 0, money = model.money + model.fish * 5 } ), Cmd.none )
