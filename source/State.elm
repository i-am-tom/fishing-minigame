module State exposing (Resources, Staff, State, deserialize, initial, serialize)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type alias State =
    { money : Float
    , resources : Resources
    , staff : Staff
    }


type alias Resources =
    { fish : Float
    }


type alias Staff =
    { fishers : Float
    }


initial : State
initial =
    { money = 0
    , resources =
        { fish = 0
        }
    , staff =
        { fishers = 0
        }
    }


serialize : State -> Encode.Value
serialize state =
    Encode.object
        [ ( "money", Encode.float state.money )
        , ( "resources", Encode.object [ ( "fish", Encode.float state.resources.fish ) ] )
        , ( "staff", Encode.object [ ( "fishers", Encode.float state.staff.fishers ) ] )
        ]


deserialize : Decoder State
deserialize =
    Decode.map3 State
        (Decode.field "money" Decode.float)
        (Decode.field "resources"
            (Decode.map Resources
                (Decode.field "fish" Decode.float)
            )
        )
        (Decode.field "staff"
            (Decode.map Staff
                (Decode.field "fishers" Decode.float)
            )
        )
