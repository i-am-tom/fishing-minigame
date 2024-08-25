module View exposing (view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, src)
import Html.Styled.Events exposing (onClick)
import State exposing (State)
import State.Delta exposing (Delta)
import Update exposing (Event(..))
import View.Controls exposing (controls)
import View.Statistics exposing (statistics)


view : Delta -> State -> Html Event
view delta state =
    div
        [ css
            [ alignItems center
            , backgroundColor (hex "FCFCFC")
            , displayFlex
            , flexDirection column
            , width (vw 100)
            ]
        ]
        [ navigation
        , mainContainer
            [ statistics delta state
            , controls state
            ]
        ]


navigation : Html Event
navigation =
    div
        [ css
            [ justifyContent center
            , borderBottom3 (px 1) solid (hex "BDBDBD")
            , boxSizing borderBox
            , boxShadow4 (px 0) (px 2) (px 4) (hex "BDBDBD")
            , displayFlex
            , position sticky
            , width (vw 100)
            ]
        ]
        [ div
            [ css
                [ alignItems center
                , boxSizing borderBox
                , displayFlex
                , fontFamilies [ "Pacifico", "sans-serif" ]
                , justifyContent spaceBetween
                , padding (px 10)
                , maxWidth (px 1000)
                , width (pc 100)
                ]
            ]
            [ h1
                [ css
                    [ fontSize (px 24)
                    , margin (px 0)
                    ]
                ]
                [ text "The Fishing Minigame"
                ]
            , img
                [ css
                    [ height (px 40)
                    , width (px 40)
                    ]
                , src "assets/logo.svg"
                ]
                []
            ]
        ]


mainContainer : List (Html Event) -> Html Event
mainContainer =
    main_
        [ css
            [ displayFlex
            , flexDirection row
            , flexGrow (int 1)
            , fontFamilies [ "Roboto", "sans-serif" ]
            , maxWidth (px 800)
            , width (vw 100)
            ]
        ]
