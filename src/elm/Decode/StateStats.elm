module Decode.StateStats exposing (..)

import Json.Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)

import Model.StateStats exposing (StateStats)


stateStatsDecoder : Decoder StateStats
stateStatsDecoder = decode StateStats
  |> required "incidents" int
  |> required "injured" int
  |> required "killed" int
  |> required "state" int
  |> required "victims" int
  |> required "year" int


stateStatsListDecoder : Decoder ( List StateStats )
stateStatsListDecoder = list stateStatsDecoder
