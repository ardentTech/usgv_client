module Command.StateStats exposing (getStateStatsList)

import Api exposing (Endpoint(StatsList), pathForEndpoint)
import Decode.StateStats exposing (stateStatsListDecoder)
import Message exposing (Msg(GetStateStatsListDone))
import Model exposing (Model)
import Rest exposing (getList)


getStateStatsList : Model -> Cmd Msg
getStateStatsList model =
  let
    url = model.docRoot ++ pathForEndpoint StatsList
  in
    getList url stateStatsListDecoder GetStateStatsListDone
