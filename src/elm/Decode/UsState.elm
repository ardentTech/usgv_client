module Decode.UsState exposing (..)

import Json.Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)

import Model.UsState exposing (UsState)


usStateListDecoder : Decoder ( List UsState )
usStateListDecoder = list ( decode UsState
  |> required "fips_code" string
  |> required "id" int
  |> required "name" string
  |> required "postal_code" string )
