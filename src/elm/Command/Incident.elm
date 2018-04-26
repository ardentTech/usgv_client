module Command.Incident exposing (..)

import Api exposing (Endpoint(IncidentList), pathForEndpoint)
import Decode.Incident exposing (incidentListDecoder)
import Message exposing (Msg(GetIncidentListDone))
import Model exposing (Model)
import QueryParam exposing (Value(..), forUrl)
import Rest exposing (getList)


getIncidentList : Model -> Cmd Msg
getIncidentList model =
  let
    url = model.docRoot ++ pathForEndpoint IncidentList ++ incidentListQuery model
  in
    getList url incidentListDecoder GetIncidentListDone


-- PRIVATE


incidentListQuery : Model -> String
incidentListQuery model =
  let
    q = [{ key = "date__year", value = IntValue model.selectedIncidentYear }]
  in
    forUrl <| case model.selectedUsState of
      Just s -> { key = "state", value = IntValue s.id } :: q
      _ -> q
