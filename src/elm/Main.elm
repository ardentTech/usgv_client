port module Main exposing (main)

import Navigation exposing (Location, programWithFlags)

import Command
import Flag exposing (Flags)
import Message exposing (Msg(..))
import Model exposing (Model)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location = 
  let
    model = Model.init flags location
  in
    ( model, Command.init model )


main : Program Flags Model Msg
main = programWithFlags UrlChange {
    init = init,
    subscriptions = subscriptions,
    update = update,
    view = view
  }
