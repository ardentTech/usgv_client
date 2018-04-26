module Command.UsState exposing (..)

import Api exposing (Endpoint(UsStateList), pathForEndpoint)
import Decode.UsState exposing (usStateListDecoder)
import Message exposing (Msg(GetUsStateListDone))
import Model exposing (Model)
import Rest exposing (getList)


getUsStateList : Model -> Cmd Msg
getUsStateList { docRoot } =
  let
    url = docRoot ++ pathForEndpoint UsStateList
  in
    getList url usStateListDecoder GetUsStateListDone
