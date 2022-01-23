module Config exposing (Config, endpoint, parseConfig)

import Json.Decode as D
import Json.Encode as E


type Config
    = Config { endpoint : String }


parseConfig : E.Value -> Result D.Error Config
parseConfig value =
    D.decodeValue configDecoder value


configDecoder : D.Decoder Config
configDecoder =
    let
        configType url =
            Config { endpoint = url }
    in
    D.map configType (D.field "endpoint" D.string)


endpoint : Config -> String
endpoint (Config c) =
    c.endpoint
