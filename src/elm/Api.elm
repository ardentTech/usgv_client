module Api exposing (pathForEndpoint)


type Endpoint = IncidentList


pathForEndpoint : Endpoint -> String
pathForEndpoint endpoint =
  case endpoint of
    IncidentList -> "incident/"
