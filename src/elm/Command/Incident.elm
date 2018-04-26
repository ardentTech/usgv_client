module Command.Incident exposing (..)

import Api exposing (Endpoint(IncidentList), pathForEndpoint)
import Message exposing (Msg(GetIncidentListDone))
import Rest exposing (getList)


getIncidentList : Model -> Cmd Msg
getIncidentList { docRoot } =
  let
    url = docRoot ++ pathForEndpoint IncidentList
  in
    getList url incidentListDecoder GetIncidentListDone
