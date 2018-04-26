module View.UsStateDropdown exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, selected, value)
import Html.Events exposing (onInput)

import Message exposing (Msg(SelectUsState))
import Model exposing (Model)
import Model.UsState exposing (UsState)


view : Model -> Html Msg
view model =
  div [ class "col-md-4 mb-3" ] [
    select [
      class "form-control form-control-sm",
      onInput SelectUsState ] <|
        allStatesOption model.selectedUsState ::
        List.map (\s -> usStateOption s model.selectedUsState) model.usStateList
  ]


usStateOption : UsState -> Maybe UsState -> Html Msg
usStateOption state selectedState =
  let
    selected_ = case selectedState of
      Just ss -> if state.fips_code == ss.fips_code then True else False
      _ -> False
  in
    option [ selected selected_, value state.fips_code ] [ text state.name ]


allStatesOption : Maybe UsState -> Html Msg
allStatesOption selectedState =
  let
    selected_ = case selectedState of
      Nothing -> True
      _ -> False
  in
    option [ selected selected_, value "*" ] [ text "* States" ]
