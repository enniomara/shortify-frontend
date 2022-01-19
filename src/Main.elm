module Main exposing (..)

import Browser
import Html exposing (Html, button, div, li, text, ul)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Item =
    { name : String }


type alias Items =
    List Item


init : Items
init =
    [ { name = "hn" }
    , { name = "pomodoro" }
    , { name = "shortify-gh" }
    ]



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Items -> Items
update msg _ =
    case msg of
        Increment ->
            [ { name = "hej" }, { name = "ho" } ]

        Decrement ->
            [ { name = "nej" }, { name = "nejjj" } ]



-- VIEW


view : Items -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , renderItems model
        , button [ onClick Increment ] [ text "+" ]
        ]


renderItems : Items -> Html Msg
renderItems items =
    ul []
        (List.map renderItem items)


renderItem : Item -> Html Msg
renderItem item =
    li []
        [ Html.a
            [ href <| String.concat [ "https://sh.mara.se/", item.name ] ]
            [ text item.name ]
        ]
