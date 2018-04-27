port module D3 exposing (..)

import Json.Encode exposing (encode, int, list, object, string)

import Model exposing (Model)
import Model.Category exposing (Category(..))
import Model.Stats exposing (Stats)
import Model.UsState exposing (UsState)


updateStats : Model -> Cmd msg
updateStats model =
  statsUpdated <| object [
    ( "metric", string <| toString <| model.selectedCategory ),
    ( "stats", list <| List.map (\s -> encodeState model s) <|
      Model.Stats.forYear model.statsList model.selectedIncidentYear )]


usStateListReady : List UsState -> Cmd msg
usStateListReady states = statesReady states


usStateSelected : Maybe UsState -> Cmd msg
usStateSelected state =
  stateSelected <| case state of
    Just s -> Just s.fips_code
    _ -> Nothing

port stateClicked : (( Maybe String ) -> msg) -> Sub msg

port stateSelected : Maybe String -> Cmd msg

port statesReady : List UsState -> Cmd msg

port statsUpdated : Json.Encode.Value -> Cmd msg

encodeState : Model ->  Stats -> Json.Encode.Value
encodeState model stats =
  let
    fips = string <| case Model.UsState.findById model.usStateList stats.state of
      Just state -> state.fips_code
      _ -> ""
    value = int <| case model.selectedCategory of
      Incidents -> stats.incidents
      Injured -> stats.injured
      Killed -> stats.killed
      Victims -> stats.victims
  in
    object [("fips", fips), ("value", value)]
