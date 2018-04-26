module View exposing (view)

import Html exposing (Html, div, h3, text)
import Html.Attributes exposing (class)

import Message exposing (Msg(..))
import Model exposing (Model)
import Router exposing (Route(..))
import View.CategoryDropdown
import View.IncidentTable
import View.IncidentYearDropdown
import View.UsStateDropdown


view : Model -> Html Msg
view model =
  let
    childView = forRoute model.currentRoute <| model
  in
    div [ class "container" ] [ childView ]


-- PRIVATE


forRoute : Maybe Route -> (Model -> Html Msg)
forRoute route =
  case route of
    Just Index -> indexView
    _ -> notFoundView


indexView : Model -> Html Msg
indexView model =
  div [ class "row mt-3" ] [
    View.IncidentYearDropdown.view model,
    View.UsStateDropdown.view model,
    View.CategoryDropdown.view model,
    View.IncidentTable.view model
  ]


notFoundView : Model -> Html Msg
notFoundView model = div [] [ h3 [] [ text "404" ] ]
