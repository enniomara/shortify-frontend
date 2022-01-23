module ConfigTest exposing (..)

import Config
import Dict exposing (Dict)
import Expect
import Json.Encode as E
import Test exposing (..)


suite : Test
suite =
    describe "config module tests"
        [ test "parsing works as expected" <|
            \_ ->
                let
                    json =
                        E.object [ ( "endpoint", E.string "http://localhost:3000" ) ]
                in
                json
                    |> Config.parseConfig
                    |> Expect.ok
        , test "get endpoint" <|
            \_ ->
                let
                    json =
                        E.object [ ( "endpoint", E.string "http://localhost:3000" ) ]
                in
                json
                    |> Config.parseConfig
                    |> Result.map Config.endpoint
                    |> Expect.equal (Ok "http://localhost:3000")
        ]
