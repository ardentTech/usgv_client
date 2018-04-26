module QueryParam exposing (..)


type Value = FloatValue Float | IntValue Int | StringValue String


type alias QueryParam = {
  key : String,
  value : Value
}


forUrl : List ( QueryParam ) -> String
forUrl queryParams =
  let
    asString qp = qp.key ++ "=" ++ case qp.value of
      FloatValue f -> toString f
      IntValue i -> toString i
      StringValue s -> s
  in
    "?" ++ ( String.join "&" <| List.map asString queryParams )
