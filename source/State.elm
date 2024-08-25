module State exposing (State, Resources, deserialize, initial, serialize)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type alias State =
    { money : Float
    , resources : Resources
    }


type alias Resources =
    { fish : Float
    }


initial : State
initial =
    { money = 0
    , resources =
        { fish = 0
        }
    }


serialize : State -> Encode.Value
serialize state =
    Encode.object
        [ ( "money", Encode.float state.money )
        , ( "resources", Encode.object [ ( "fish", Encode.float state.resources.fish ) ] )
        ]


deserialize : Decoder State
deserialize =
    Decode.map2 State
        (Decode.field "money" Decode.float)
        (Decode.field "resources"
            (Decode.map Resources
                (Decode.field "fish" Decode.float)
            )
        )
