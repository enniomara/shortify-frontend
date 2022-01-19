module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, li, text, ul)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick, onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { items : Items, searchTerm : Maybe String }


type alias Item =
    { name : String }


type alias Items =
    List Item


init : Model
init =
    { items =
        [ { name = "hn" }
        , { name = "pomodoro" }
        , { name = "shortify-gh" }
        ]
    , searchTerm = Nothing
    }



-- UPDATE


type Msg
    = Increment
    | Decrement
    | InputChange String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { items = [ { name = "hej" }, { name = "ho" } ], searchTerm = Nothing }

        Decrement ->
            { items = [ { name = "nej" }, { name = "nejjj" } ], searchTerm = Nothing }

        InputChange content ->
            { model | searchTerm = Just content }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , input [ onInput InputChange ] []
        , renderItems model.items model.searchTerm
        , button [ onClick Increment ] [ text "+" ]
        ]


renderItems : Items -> Maybe String -> Html Msg
renderItems items searchTerm =
    ul []
        (List.map renderItem (matchSearchTerm searchTerm items))


matchSearchTerm : Maybe String -> Items -> Items
matchSearchTerm searchTerm items =
    case searchTerm of
        Nothing ->
            items

        Just term ->
            List.filter (contains term) items


contains : String -> Item -> Bool
contains searchTerm item =
    String.contains searchTerm item.name


renderItem : Item -> Html Msg
renderItem item =
    li []
        [ Html.a
            [ href <| String.concat [ "https://sh.mara.se/", item.name ] ]
            [ text item.name ]
        ]
