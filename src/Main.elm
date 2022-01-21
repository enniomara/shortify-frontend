module Main exposing (..)

import Browser
import Html exposing (Html, div, input, li, text, ul)
import Html.Attributes exposing (autofocus, href)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MODEL


type alias Model =
    { items : Items, searchTerm : Maybe String }


type alias Item =
    { name : String }


type alias Items =
    List Item


init : () -> ( Model, Cmd Msg )
init _ =
    ( { items =
            [ { name = "hn" }
            , { name = "pomodoro" }
            , { name = "shortify-gh" }
            ]
      , searchTerm = Nothing
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = SearchInputChange String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchInputChange content ->
            case content of
                "" ->
                    ( { model | searchTerm = Nothing }, Cmd.none )

                _ ->
                    ( { model | searchTerm = Just content }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput SearchInputChange, autofocus True ] []
        , renderItems model.items model.searchTerm
        ]


renderItems : Items -> Maybe String -> Html Msg
renderItems items searchTerm =
    ul []
        (List.map renderItem (filter searchTerm items))


filter : Maybe String -> Items -> Items
filter searchTerm items =
    case searchTerm of
        Nothing ->
            items

        Just term ->
            List.filter (contains term) items


contains : String -> Item -> Bool
contains searchTerm =
    String.contains searchTerm << .name


renderItem : Item -> Html Msg
renderItem item =
    li []
        [ Html.a
            [ href <| String.concat [ "https://sh.mara.se/", item.name ] ]
            [ text item.name ]
        ]
