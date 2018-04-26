module Main exposing (main)

import Navigation exposing (Location, programWithFlags)

import Flag exposing (Flags)
import Message exposing (Msg(..))
import Model exposing (Model)
import Update exposing (update)
import View exposing (view)


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location = (Model.init flags location, Cmd.none)


main : Program Flags Model Msg
main = programWithFlags UrlChange {
    init = init,
    subscriptions = always Sub.none,
    update = update,
    view = view
  }
