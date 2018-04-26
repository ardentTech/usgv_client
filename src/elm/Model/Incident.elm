module Model.Incident exposing (Incident)

import Date


type alias Incident = {
  city_county : String,
  date : Date.Date,
  id : Int,
  injured : Int,
  killed : Int,
  state : Int,  -- UsState.id
  street : String,
  url : String,
  victims : Int
}
