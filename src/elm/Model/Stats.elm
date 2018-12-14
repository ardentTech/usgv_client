module Model.Stats exposing (Stats, calculate, init)

import Model.Incident exposing (Incident)


type alias Stats = {
  incidents : Int,
  injured : Int,
  killed : Int,
  victims : Int
}


calculate : List Incident -> Stats
calculate incidents =
  let
    incidentTotal = List.length incidents
    injuredTotal = List.sum <| List.map .injured incidents
    killedTotal = List.sum <| List.map .killed incidents
    victimTotal = List.sum <| List.map .victims incidents
  in
    { incidents = incidentTotal, injured = injuredTotal, killed = killedTotal, victims = victimTotal }


init : Stats
init = { incidents = 0, injured = 0, killed = 0, victims = 0 }
