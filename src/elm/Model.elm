module Model exposing (..)

import Navigation exposing (Location)
import Table
import Time
import UrlParser exposing (parsePath)

import Alert exposing (Alert)
import Flag exposing (Flags)
import Model.Category exposing (Category(..))
import Model.Incident exposing (Incident)
import Model.UsState exposing (UsState)
import Router exposing (Route, route)


type alias Model = {
  alert : Alert,
  currentRoute : Maybe Route,
  currentTime : Maybe Time.Time,
  docRoot : String,
  incidentList : List Incident,
  incidentTableState : Table.State,
  selectedCategory : Category,
  selectedIncidentYear : Int,
  selectedUsState : Maybe UsState,
  usStateList : List UsState
}


init : Flags -> Location -> Model
init flags location = {
  alert = Alert.init,
  currentRoute = parsePath route location,
  currentTime = Nothing,
  docRoot = flags.docRoot,
  incidentList = [],
  incidentTableState = Table.initialSort "Id",
  selectedCategory = Incidents,
  selectedIncidentYear = 2018,
  selectedUsState = Nothing,
  usStateList = []}
