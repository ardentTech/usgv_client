module View exposing (view)

import Html exposing (Html, a, div, h4, small, text)
import Html.Attributes exposing (class, href, id)

import Message exposing (Msg(..))
import Model exposing (Model)
import Router exposing (Route(..))
import Svg exposing (svg)
import View.CategoryDropdown
import View.IncidentTable
import View.IncidentYearDropdown
import View.UsStateDropdown


view : Model -> Html Msg
view model =
  let
    childView = forRoute model.currentRoute <| model
  in
    div [ class "container" ] [
      div [ class "row mb-3 mt-3" ] [
        div [ class "col-12" ] [
          h4 [ class "text-center" ] [ text "US Mass Shootings (2014-2018)" ]
        ]
      ],
      childView,
      div [ class "row pb-4", id "footer" ] [
        div [ class "col-12 text-center text-muted" ] [
          a [ href "https://github.com/ardentTech/usgv_client" ] [ text "code by Ardent Technicreative" ],
          text " // ",
          a [ href "http://www.gunviolencearchive.org" ] [ text "data by Gun Violence Archive" ]
        ]
      ]
    ]


-- PRIVATE


forRoute : Maybe Route -> (Model -> Html Msg)
forRoute route =
  case route of
    Just Index -> indexView
    _ -> notFoundView


indexView : Model -> Html Msg
indexView model =
  div [ class "row" ] [
    View.IncidentYearDropdown.view model,
    View.UsStateDropdown.view model,
    View.CategoryDropdown.view model,
    div [ class "col-12", id "vis" ] [ svg [] []],
    View.IncidentTable.view model
  ]


notFoundView : Model -> Html Msg
notFoundView model = div [ class "row" ] [ h4 [] [ text "404" ] ]
