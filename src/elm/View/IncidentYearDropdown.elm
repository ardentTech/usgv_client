module View.IncidentYearDropdown exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, selected, value)
import Html.Events exposing (on, targetValue)
import Json.Decode exposing (Decoder, andThen, fail, succeed)

import Message exposing (Msg(SelectIncidentYear))
import Model exposing (Model)


view : Model -> Html Msg
view { selectedIncidentYear } =
  let
    toOption v = option [
      selected <| if v == selectedIncidentYear then True else False, value <| toString v ] [ text <| toString v ]
    options = List.map toOption [2019, 2018, 2017, 2016, 2015, 2014]
  in
    div [ class "col-md-4 mb-3" ] [
      select [ 
        class "form-control form-control-sm",
        onInputStringToInt SelectIncidentYear ] options
    ]


-- PRIVATE


onInputStringToInt : (Int -> msg) -> Html.Attribute msg
onInputStringToInt tagger =
  on "input" ( targetValue |> customDecoder String.toInt |> Json.Decode.map tagger )


customDecoder : (a -> Result String b) -> Decoder a -> Decoder b
customDecoder fResult decoder =
  decoder |> andThen (fResult >> eitherR fail succeed)


eitherR : (x -> b) -> (a -> b) -> Result x a -> b
eitherR fErr fOk result =
  case result of
    Ok a -> fOk a
    Err e -> fErr e
