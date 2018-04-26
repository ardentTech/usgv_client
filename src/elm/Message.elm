module Message exposing (Msg(..))

import Navigation exposing (Location)
import Time

import Alert


type Msg =
  AlertMsg Alert.Msg |
  CurrentTime Time.Time |
  NewUrl String |
  NoOp |
  UrlChange Location
