module Command exposing (forMsg)

import Task
import Time

import Message exposing (Msg(..))


forMsg : Msg -> Cmd Msg
forMsg msg =
  case msg of
    UrlChange location -> Cmd.none
    _ -> Cmd.none


getCurrentTime : Cmd Msg
getCurrentTime = Task.perform CurrentTime Time.now
