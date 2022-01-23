module Main exposing (..)

import Browser
import Config
import Html exposing (Html, div, input, li, span, text, ul)
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
    { items : Status Items
    , searchTerm : Maybe String
    , config : Config.Config
    }


type Status a
    = Loading
    | Loaded a


type alias Item =
    { name : String }


type alias Items =
    List Item


init : E.Value -> ( Model, Cmd Msg )
init flags =
    case Config.parseConfig flags of
        Ok config ->
            ( { items = Loading
              , searchTerm = Nothing
              , config = config
              }
            , Http.get
                { url = Url.Builder.crossOrigin (Config.endpoint config) [ "_entries" ] []
                , expect = Http.expectJson LoadedItems itemsDecoder
                }
            )

        Err status ->
            Debug.todo <| D.errorToString status



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
                    ( { model | items = Loaded items }, Cmd.none )

                Err _ ->
                    Debug.todo "Handle error"



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput SearchInputChange, autofocus True ] []
        , renderItems model.items model.searchTerm (Config.endpoint model.config)
        ]


renderItems : Status Items -> Maybe String -> String -> Html Msg
renderItems statusItems searchTerm endpoint =
    case statusItems of
        Loading ->
            div [] [ span [] [ text "Loading" ] ]

        Loaded items ->
            ul []
                (List.map (renderItem endpoint) (filter searchTerm items))


renderItem : String -> Item -> Html Msg
renderItem endpoint item =
    li []
        [ Html.a
            [ href <| String.concat [ endpoint, "/", item.name ] ]
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
