module View.IncidentTable exposing (view)

import Date
import Html exposing (..)
import Html.Attributes exposing (class, href, target)
import Table exposing (defaultCustomizations)

import Message exposing (Msg(SetIncidentTableState))
import Model exposing (Model)
import Model.Incident exposing (Incident)
import Model.UsState exposing (findById)


view : Model -> Html Msg
view model =
  div [ class "col-12" ] [
    Table.view ( tableConfig model ) model.incidentTableState model.incidentList
  ]


tableConfig : Model -> Table.Config Incident Msg
tableConfig model =
  let
    stateName id = case findById model.usStateList id of
      Just state -> state.name
      _ -> toString id
    tableAttrs = [ class "table table-responsive-md table-sm table-striped" ]
  in
    Table.customConfig {
      toId = toString << .id,
      toMsg = SetIncidentTableState,
      columns = [
        Table.stringColumn "Date" (dateFormat << .date),
        Table.intColumn "Injured" .injured,
        Table.intColumn "Killed" .killed,
        Table.intColumn "Victims" .victims,
        Table.stringColumn "City" .city_county,
        Table.stringColumn "State" (stateName << .state),
        detailsColumn ],
      customizations = { defaultCustomizations | tableAttrs = tableAttrs }
    }


viewDetails : Incident -> Table.HtmlDetails Msg
viewDetails { url } =
  Table.HtmlDetails [] [ a [ href url, target "_blank" ] [ text "More Info" ]]


detailsColumn : Table.Column Incident Msg
detailsColumn =
  Table.veryCustomColumn {
    name = "",
    viewData = viewDetails,
    sorter = Table.unsortable
  }


dateFormat : Date.Date -> String
dateFormat date =
  toString (Date.month date) ++ " " ++
  toString (Date.day date) ++ ", " ++
  toString (Date.year date)
