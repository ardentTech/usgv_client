module Model exposing (..)

import Navigation exposing (Location)
import Time
import UrlParser exposing (parsePath)

import Alert exposing (Alert)
import Flag exposing (Flags)
import Model.UsState exposing (UsState)
import Router exposing (Route, route)


type alias Model = {
  alert : Alert,
  currentRoute : Maybe Route,
  currentTime : Maybe Time.Time,
  docRoot : String,
  selectedUsState : Maybe UsState,
  usStateList : List UsState
}


init : Flags -> Location -> Model
init flags location = {
  alert = Alert.init,
  currentRoute = parsePath route location,
  currentTime = Nothing,
  docRoot = flags.docRoot,
  selectedUsState = Nothing,
  usStateList = []}
