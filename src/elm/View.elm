module View exposing (view)

import Html exposing (Html, div, h3, text)
import Html.Attributes exposing (class)

import Message exposing (Msg(..))
import Model exposing (Model)
import Router exposing (Route(..))


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
  div [] [
    text <| toString model.usStateList
  ]


notFoundView : Model -> Html Msg
notFoundView model = div [] [ h3 [] [ text "404" ] ]
