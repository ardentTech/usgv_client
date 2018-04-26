module Update exposing (update)

import Navigation exposing (newUrl)
import UrlParser exposing (parsePath)

import Alert
import Command
import Message exposing (Msg(..))
import Model exposing (Model) 
import Model.UsState
import Router exposing (route)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  let
    noOp = model ! []
  in
    case msg of
      AlertMsg message -> { model | alert = Alert.update message model.alert } ! []
      CurrentTime time -> { model | currentTime = Just time } ! []
      GetUsStateListDone response ->
        case response of
          Ok r -> { model | usStateList = r } ! []
          Err e -> model ! []
      NewUrl url -> ( model, newUrl url )
      NoOp -> noOp
      SelectUsState fips ->
        { model | selectedUsState = Model.UsState.findByFips model.usStateList fips } ! []
      UrlChange location -> (
        { model | currentRoute = parsePath route location }, Command.forMsg msg )
