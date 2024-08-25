module StateTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer)
import Json.Decode as Decode
import State exposing (Resources, State, deserialize, serialize)
import Test exposing (Test, describe, fuzz)


stateFuzzer : Fuzzer State
stateFuzzer =
    Fuzz.map3 State
        Fuzz.niceFloat
        (Fuzz.map Resources
            Fuzz.niceFloat
        )
        (Fuzz.map Staff
            Fuzz.niceFloat
        )


suite : Test
suite =
    describe "State"
        [ fuzz stateFuzzer "round-trip serialization" <|
            \state ->
                Decode.decodeValue deserialize (serialize state)
                    |> Expect.equal (Ok state)
        ]
