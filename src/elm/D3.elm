port module D3 exposing (usStateSelected, usStateListReady)

import Model.UsState exposing (UsState)


usStateListReady : List UsState -> Cmd msg
usStateListReady states = statesReady states


usStateSelected : Maybe UsState -> Cmd msg
usStateSelected state =
  stateSelected <| case state of
    Just s -> Just s.fips_code
    _ -> Nothing


port stateSelected : Maybe String -> Cmd msg

port statesReady : List UsState -> Cmd msg
