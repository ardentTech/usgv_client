module Decode exposing (Pagination, date, paginationDecoder)

import Date
import Json.Decode exposing (Decoder, andThen, int, nullable, string)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Decode.Extra exposing (fromResult)


type alias Pagination a = {
  count : Int,
  next : Maybe String,
  previous : Maybe String,
  results : List a
}


date : Decoder Date.Date
date = string |> andThen (Date.fromString >> fromResult)


paginationDecoder : Decoder (List a) -> Decoder (Pagination a)
paginationDecoder listDecoder = decode Pagination
  |> required "count" int
  |> required "next" (nullable string)
  |> required "previous" (nullable string)
  |> required "results" listDecoder
