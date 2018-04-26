module Message exposing (Msg(..))

import Http exposing (Error)
import Result exposing (Result)
import Navigation exposing (Location)
import Table
import Time

import Alert
import Model.Incident exposing (Incident)
import Model.UsState exposing (UsState)


type Msg =
  AlertMsg Alert.Msg |
  CurrentTime Time.Time |
  GetIncidentListDone ( Result Error ( List Incident )) |
  GetUsStateListDone ( Result Error ( List UsState )) |
  NewUrl String |
  NoOp |
  SelectCategory String |
  SelectIncidentYear Int |
  SelectUsState String |
  SetIncidentTableState Table.State |
  UrlChange Location
