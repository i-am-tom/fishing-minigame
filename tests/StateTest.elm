module StateTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer)
import Test exposing (Test, describe, fuzz)
import State exposing (State, deserialize, serialize)
import Json.Decode as Decode

stateFuzzer : Fuzzer State
stateFuzzer =
  Fuzz.map State
    Fuzz.niceFloat

suite : Test
suite =
  describe "State"
    [ fuzz stateFuzzer "round-trip serialization" <| \state ->
        Decode.decodeValue deserialize (serialize state)
          |> Expect.equal (Ok state)
    ]
