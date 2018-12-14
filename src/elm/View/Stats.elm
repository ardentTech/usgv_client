module View.Stats exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href, target)

import Message exposing (Msg)
import Model exposing (Model)


view : Model -> Html Msg
view model =
  div [ class "col-12 mb-3" ] [
    h5 [] [ text "Total Stats" ],
    table [ class "table table-responsive-md table-sm table-striped" ] [
      thead [] [
        tr [] [
          th [] [ text "Incidents" ],
          th [] [ text "Injured" ],
          th [] [ text "Killed" ],
          th [] [ text "Victims" ]
        ]
      ],
      tbody [] [
        tr [] [
          td [] [ text <| toString model.stats.incidents ],
          td [] [ text <| toString model.stats.injured ],
          td [] [ text <| toString model.stats.killed ],
          td [] [ text <| toString model.stats.victims ]
        ]
      ] 
    ]
  ]


-- PRIVATE
