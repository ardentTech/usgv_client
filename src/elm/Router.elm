module Router exposing (Route(..), route, toPath)

import UrlParser exposing (..)


type Route = Index | NotFound


route : Parser (Route -> a) a
route = oneOf [
  map Index top,
  map NotFound (s "not-found")]


toPath : Route -> String
toPath r =
  case r of
    Index -> "/"
    NotFound -> "/not-found"
