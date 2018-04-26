module Crime.Decode exposing (..)

import Date exposing (Date)
import Date.Extra exposing (fromIsoString)
import Json.Decode exposing (Decoder, andThen, fail, int, list, string, succeed)
import Json.Decode.Extra exposing (fromResult)
import Json.Decode.Pipeline exposing (decode, required)

import Model.Incident exposing (Incident)


incidentDecoder : Decoder Incident
incidentDecoder = decode Incident
  |> required "city_county" string
  |> required "date" date
  |> required "id" int
  |> required "injured" int
  |> required "killed" int
  |> required "state" int
  |> required "street" string
  |> required "url" string
  |> required "victims" int


-- PRIVATE


date : Decoder Date
date = string |> andThen (fromIsoString >> fromResult)
