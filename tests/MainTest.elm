module MainTest exposing (..)

import Expect
import Main exposing (Item, Items)
import Test exposing (..)


filterItems : Test
filterItems =
    describe "Filtering functionality"
        [ test "right amount of items when needle is found"
            (\_ ->
                let
                    items =
                        [ Item "hn", Item "shortify", Item "pomodoro" ]
                in
                items
                    -- Matches shortify and pomodoro
                    |> Main.filter (Just "or")
                    |> List.length
                    |> Expect.equal 2
            )
        ]
