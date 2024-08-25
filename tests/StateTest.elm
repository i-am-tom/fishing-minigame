module StateTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer)
import Json.Decode as Decode
import State exposing (State, Resources, deserialize, serialize)
import Test exposing (Test, describe, fuzz)


stateFuzzer : Fuzzer State
stateFuzzer =
    Fuzz.map2 State
        Fuzz.niceFloat
        ( Fuzz.map Resources
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
