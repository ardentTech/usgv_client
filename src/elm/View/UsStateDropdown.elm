module View.UsStateDropdown exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, value)
import Html.Events exposing (onInput)

import Message exposing (Msg(SelectUsState))
import Model exposing (Model)


view : Model -> Html Msg
view model =
  let
    toOption s = option [ value s.fips_code ] [ text s.name ]
  in
    div [] [
      select [
        class "form-control form-control-sm",
        onInput SelectUsState ] <| List.map toOption model.usStateList
    ]
