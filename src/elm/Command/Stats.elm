module Command.Stats exposing (getStatsList)

import Api exposing (Endpoint(StatsList), pathForEndpoint)
import Decode.Stats exposing (statsListDecoder)
import Message exposing (Msg(GetStatsListDone))
import Model exposing (Model)
import Rest exposing (getList)


getStatsList : Model -> Cmd Msg
getStatsList model =
  let
    url = model.docRoot ++ pathForEndpoint StatsList
  in
    getList url statsListDecoder GetStatsListDone
