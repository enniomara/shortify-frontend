module Main exposing (..)

import Browser
import Html exposing (Html, div, input, li, text, ul)
import Html.Attributes exposing (autofocus, href)
import Html.Events exposing (onInput)
import Http
import Json.Decode as D
import Json.Encode as E
import Url.Builder



-- MAIN


main : Program E.Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- MODEL


type alias Model =
    { items : Items
    , searchTerm : Maybe String
    , config : Config
    }


type alias Item =
    { name : String }


type alias Items =
    List Item


type alias Config =
    { endpoint : String }


init : E.Value -> ( Model, Cmd Msg )
init flags =
    case D.decodeValue configDecoder flags of
        Ok config ->
            ( { items =
                    [ { name = "hn" }
                    , { name = "pomodoro" }
                    , { name = "shortify-gh" }
                    ]
              , searchTerm = Nothing
              , config = config
              }
            , Http.get
                { url = Url.Builder.crossOrigin config.endpoint [ "entries" ] []
                , expect = Http.expectJson LoadedItems itemsDecoder
                }
            )

        Err status ->
            Debug.todo <| D.errorToString status


configDecoder : D.Decoder Config
configDecoder =
    D.map Config (D.field "endpoint" D.string)



-- UPDATE


type Msg
    = SearchInputChange String
    | LoadedItems (Result Http.Error Items)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchInputChange content ->
            case content of
                "" ->
                    ( { model | searchTerm = Nothing }, Cmd.none )

                _ ->
                    ( { model | searchTerm = Just content }, Cmd.none )

        LoadedItems result ->
            case result of
                Ok items ->
                    ( { model | items = items }, Cmd.none )

                Err _ ->
                    Debug.todo "Handle error"



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


renderItem : Item -> Html Msg
renderItem item =
    li []
        [ Html.a
            [ href <| String.concat [ "https://sh.mara.se/", item.name ] ]
            [ text item.name ]
        ]



-- UTILS


filter : Maybe String -> Items -> Items
filter searchTerm items =
    case searchTerm of
        Nothing ->
            items

        Just term ->
            List.filter (contains term) items


contains : String -> Item -> Bool
contains searchTerm =
    String.contains searchTerm << String.toLower << .name


itemsDecoder : D.Decoder Items
itemsDecoder =
    D.list itemDecoder


itemDecoder : D.Decoder Item
itemDecoder =
    D.map Item (D.field "name" D.string)
