module Command exposing (forMsg, init)

import Task
import Time

import Command.Incident exposing (getIncidentList)
import Command.UsState exposing (getUsStateList)
import Message exposing (Msg(..))
import Model exposing (Model)


forMsg : Msg -> Cmd Msg
forMsg msg =
  case msg of
    UrlChange location -> Cmd.none
    _ -> Cmd.none


getCurrentTime : Cmd Msg
getCurrentTime = Task.perform CurrentTime Time.now


init : Model -> Cmd Msg
init model =
  Cmd.batch [ getCurrentTime, getIncidentList model, getUsStateList model ]
