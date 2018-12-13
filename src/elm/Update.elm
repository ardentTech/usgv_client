module Update exposing (update)

import Navigation exposing (newUrl)
import UrlParser exposing (parsePath)

import Alert
import Command
import Command.Incident exposing (getIncidentList)
import Command.StateStats exposing (getStateStatsList)
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
      GetStateStatsListDone response ->
        case response of
          Ok r ->
            let
              model_ = { model | stateStatsList = r }
            in
              model_ ! [ D3.updateStats model_ ]
          Err e -> model ! []
      GetUsStateListDone response ->
        case response of
          Ok r ->
            let
              model_ = { model | usStateList = r }
            in
              model_ ! [
                getIncidentList model_,
                getStateStatsList model_,
                D3.usStateListReady r
              ]
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
          { model | selectedCategory = category_ } ! [ D3.updateStats model ]
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
          model_ ! [ getIncidentList model_, D3.updateStats model_ ]
      SetIncidentTableState state -> { model | incidentTableState = state } ! []
      UrlChange location -> (
        { model | currentRoute = parsePath route location }, Command.forMsg msg )
      UsStateClicked fips ->
        let
          model_ = case fips of
            Just fips_ -> {
              model | selectedUsState = Model.UsState.findByFips model.usStateList fips_ }
            _ -> { model | selectedUsState = Nothing }
        in
          model_ ! [ getIncidentList model_ ]
