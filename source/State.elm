module State exposing (State, deserialize, initial, serialize)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type alias State =
    { fish : Float
    , money : Float
    }


initial : State
initial =
    { fish = 0
    , money = 0
    }


serialize : State -> Encode.Value
serialize state =
    Encode.object
        [ ( "money", Encode.float state.money )
        ]


deserialize : Decoder State
deserialize =
    Decode.map2 State
        (Decode.field "fish" Decode.float)
        (Decode.field "money" Decode.float)
