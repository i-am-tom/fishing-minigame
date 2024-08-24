module Update exposing (Event(..), update)

import AssocList as Dict exposing (Dict)
import Random exposing (Generator)
import State exposing (State)
import State.Delta exposing (Delta, gradient, step)


type Event
    = NoOp
    | CatchFish
    | SellFish
    | Probabilities (Dict Event Float)


update : Event -> State -> ( State, Cmd Event )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Probabilities entries ->
            let
                generateEntry : ( Event, Float ) -> Cmd (Maybe Event)
                generateEntry ( key, threshold ) =
                    Random.float 0 1
                        |> Random.generate
                            (\roll ->
                                if roll < threshold then
                                    Just key

                                else
                                    Nothing
                            )

                results : Cmd Event
                results =
                    entries
                        |> Dict.toList
                        |> List.map generateEntry
                        |> Cmd.batch
                        |> Cmd.map (Maybe.withDefault NoOp)
            in
            ( model, results )

        CatchFish ->
            ( { model | fish = model.fish + 1 }, Cmd.none )

        SellFish ->
            ( { model | fish = 0, money = model.money + model.fish * 5 }, Cmd.none )
