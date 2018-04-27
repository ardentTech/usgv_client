module Decode.Stats exposing (..)

import Json.Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)

import Model.Stats exposing (Stats)


statsDecoder : Decoder Stats
statsDecoder = decode Stats
  |> required "incidents" int
  |> required "injured" int
  |> required "killed" int
  |> required "state" int
  |> required "victims" int
  |> required "year" int


statsListDecoder : Decoder ( List Stats )
statsListDecoder = list statsDecoder
