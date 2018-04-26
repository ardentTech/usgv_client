module Api exposing (Endpoint(..), pathForEndpoint)


type Endpoint = IncidentList | UsStateList


pathForEndpoint : Endpoint -> String
pathForEndpoint endpoint =
  case endpoint of
    IncidentList -> "incident/"
    UsStateList -> "us-state/"
