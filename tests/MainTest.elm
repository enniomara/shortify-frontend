module MainTest exposing (..)

import Expect
import Main exposing (Item, Items)
import Test exposing (..)


filterItems : Test
filterItems =
    describe "Filtering functionality"
        [ describe "filter tests"
            [ test "right amount of items when needle is found" <|
                \_ ->
                    let
                        items =
                            [ Item "hn", Item "shortify", Item "pomodoro" ]
                    in
                    items
                        -- Matches shortify and pomodoro
                        |> Main.filter (Just "or")
                        |> List.length
                        |> Expect.equal 2
            , test "same item when needle is empty" <|
                \_ ->
                    let
                        items =
                            [ Item "hn", Item "shortify", Item "pomodoro" ]
                    in
                    items
                        -- Matches shortify and pomodoro
                        |> Main.filter Nothing
                        |> List.length
                        |> Expect.equal 3
            , test "that filter is case insensitive" <|
                \_ ->
                    let
                        items =
                            [ Item "Response", Item "rest" ]
                    in
                    items
                        |> Main.filter (Just "re")
                        |> List.length
                        |> Expect.equal 2
            ]
        , describe "contains tests"
            [ test "should contain with empty needle" <|
                \_ ->
                    Item "pomodoro"
                        |> Main.contains ""
                        |> Expect.equal True
            , test "should contain with substring" <|
                \_ ->
                    Item "pomodoro"
                        |> Main.contains "omo"
                        |> Expect.equal True
            , test "should not contain with random needle" <|
                \_ ->
                    Item "pomodoro"
                        |> Main.contains "other"
                        |> Expect.equal False
            ]
        ]
