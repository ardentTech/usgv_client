module Message exposing (Msg(..))

import Http exposing (Error)
import Result exposing (Result)
import Navigation exposing (Location)
import Time

import Alert
import Model.UsState exposing (UsState)


type Msg =
  AlertMsg Alert.Msg |
  CurrentTime Time.Time |
  GetUsStateListDone ( Result Error ( List UsState )) |
  NewUrl String |
  NoOp |
  UrlChange Location
