module View.Controls exposing (controls)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import State exposing (State)
import State.Delta exposing (Delta)
import Update exposing (Event(..))


controls : State -> Html Event
controls state =
    div
        [ css
            [ flexGrow (int 1)
            , padding (px 10)
            ]
        ]
        [ button [ onClick CatchFish ]
            [ text "Catch fish"
            ]
        , button [ onClick SellFish ]
            [ text "Sell fish"
            ]
        , button [ onClick HireFisher ]
            [ text "Hire fisher"
            ]
        ]
