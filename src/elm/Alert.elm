module Alert exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onClick)


type Category =
  Danger | Dark | Info | List | Primary | Secondary | Success | Warning


type alias Alert = {
  body : List ( Html Msg ),
  category : Category,
  visible : Bool
}


type Msg = Hide | Show


init : Alert
init = { body = [], category = Info, visible = False }


update : Msg -> Alert -> Alert
update msg alert =
  case msg of
    Hide -> { alert | visible = False }
    Show -> { alert | visible = True }


view : Alert -> Html Msg 
view alert =
  div [ class "alert" ] [
    div [] alert.body,
    button [ class "close", onClick Hide, type_ "button" ] [ span [] [ text "×" ]]
  ]
