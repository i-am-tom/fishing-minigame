module View.Statistics exposing (statistics)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import NumberSuffix exposing (standardConfig, suffixStandardShort)
import State exposing (State)
import State.Delta exposing (Delta)
import Update exposing (Event(..))


statistics : Delta -> State -> Html Event
statistics delta state =
    ul
        [ css
            [ listStyleType none
            , margin (px 0)
            , padding (px 0)
            , maxWidth (px 300)
            , width (vw 40)
            ]
        ]
        (List.map (renderDisplay delta state) displays)


type alias Display =
    { label : String
    , color : Color
    , shouldShow : State -> Bool
    , current : State -> Float
    , gradient : Delta -> Float
    , format : String -> String
    }


displays : List Display
displays =
    [ { label = "Fish"
      , color = rgb 79 79 79
      , shouldShow = \_ -> True
      , current = \s -> s.resources.fish
      , gradient = \s -> s.resources.fish
      , format = \s -> s ++ "kg"
      }
    , { label = "Money"
      , color = rgb 33 150 83
      , shouldShow = \_ -> True
      , current = .money
      , gradient = .money
      , format = \s -> "$" ++ s
      }
    ]


renderDisplay : Delta -> State -> Display -> Html Event
renderDisplay delta state display =
    let
        formatNumber : Float -> String
        formatNumber =
            NumberSuffix.format
                { standardConfig
                    | getSuffix = suffixStandardShort
                    , sigfigs = 3
                    , minSuffix = 1000
                }

        gradient : Float
        gradient =
            display.gradient delta
    in
    li
        [ css
            [ boxSizing borderBox
            , displayFlex
            , fontSize (px 13)
            , flexDirection column
            , height (px 55)
            , justifyContent spaceBetween
            , borderBottom3 (px 1) solid (hex "E0E0E0")
            , padding (px 10)
            , overflowX hidden
            ]
        ]
        [ strong
            [ css
                [ color display.color
                ]
            ]
            [ text display.label
            ]
        , div []
            [ strong []
                [ display.current state
                    |> formatNumber
                    |> display.format
                    |> text
                ]
            , if gradient > 0 then
                text (" + " ++ (gradient |> formatNumber |> display.format) ++ "/s")

              else if gradient == 0 then
                text ""

              else
                text (" - " ++ (gradient |> abs |> formatNumber |> display.format) ++ "/s")
            ]
        ]
