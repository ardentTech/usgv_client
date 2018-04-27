module Update exposing (update)

import Navigation exposing (newUrl)
import UrlParser exposing (parsePath)

import Alert
import Command
import Command.Incident exposing (getIncidentList)
import D3
import Message exposing (Msg(..))
import Model exposing (Model) 
import Model.Category exposing (Category(..))
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
      GetIncidentListDone response ->
        case response of
          Ok r -> { model | incidentList = r } ! []
          Err e -> model ! []
      GetUsStateListDone response ->
        case response of
          Ok r -> { model | usStateList = r } ! [ D3.usStateListReady r ]
          Err e -> model ! []
      NewUrl url -> ( model, newUrl url )
      NoOp -> noOp
      SelectCategory category ->
        let
          category_ = case category of
            "Incidents" -> Incidents
            "Injured" -> Injured
            "Killed" -> Killed
            "Victims" -> Victims
            _ -> Incidents
        in
          { model | selectedCategory = category_ } ! []
      SelectUsState fips ->
        let
          state = Model.UsState.findByFips model.usStateList fips
          model_ = { model | selectedUsState = state }
        in
          model_ ! [ getIncidentList model_, D3.usStateSelected state ]
      SelectIncidentYear year ->
        let
          model_ = { model | selectedIncidentYear = year }
        in
          model_ ! [ getIncidentList model_ ]
      SetIncidentTableState state -> { model | incidentTableState = state } ! []
      UrlChange location -> (
        { model | currentRoute = parsePath route location }, Command.forMsg msg )
