module Api exposing (Endpoint(..), pathForEndpoint)


type Endpoint = IncidentList | StatsList | UsStateList


pathForEndpoint : Endpoint -> String
pathForEndpoint endpoint =
  case endpoint of
    IncidentList -> "incident/"
    StatsList -> "incident/stats/"
    UsStateList -> "us-state/"
