module View.CategoryDropdown exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, selected, value)
import Html.Events exposing (onInput)

import Message exposing (Msg(SelectCategory))
import Model exposing (Model)
import Model.Category exposing (Category, categories)


view : Model -> Html Msg
view model =
  div [ class "col-md-4 mb-3" ] [
    select [
        class "form-control form-control-sm",
        onInput SelectCategory ] <|
      List.map (\c -> categoryOption c model.selectedCategory) categories
  ]


categoryOption : Category -> Category -> Html Msg
categoryOption category selectedCategory =
  let
    asString = toString category
    selected_ = if category == selectedCategory then True else False
  in
    option [ selected selected_, value asString ] [ text asString ]
