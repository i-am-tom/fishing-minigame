module Update exposing (Event(..), update)

import AssocList as Dict exposing (Dict)
import Constants
import Random exposing (Generator)
import State exposing (State)
import State.Delta exposing (Delta, gradient, step)


type Event
    = NoOp
    | Probabilities (Dict Event Float)
    | CatchFish
    | HireFisher
    | SellFish


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
            let
                resources =
                    model.resources
            in
            ( { model
                | resources =
                    { resources
                        | fish = model.resources.fish + 1
                    }
              }
            , Cmd.none
            )

        SellFish ->
            let
                resources =
                    model.resources
            in
            ( { model
                | resources = { resources | fish = 0 }
                , money =
                    model.money + model.resources.fish * Constants.fishPricePerKilo
              }
            , Cmd.none
            )

        HireFisher ->
            let
                staff =
                    model.staff
            in
            ( { model
                | staff = { staff | fishers = model.staff.fishers + 1 }
              }
            , Cmd.none
            )
