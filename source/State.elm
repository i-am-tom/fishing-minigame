module State exposing (State, deserialize, initial, serialize)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type alias State =
    { money : Float
    }


initial : State
initial =
    { money = 0
    }


serialize : State -> Encode.Value
serialize state =
    Encode.object
        [ ( "money", Encode.float state.money )
        ]


deserialize : Decoder State
deserialize =
    Decode.map State
        (Decode.field "money" Decode.float)
