module Model.UsState exposing (UsState)


type alias UsState = {
  fips_code : String,
  id : Int,
  name : String,
  postal_code : String
}


findByFips : List UsState -> String -> Maybe UsState
findByFips states fips =
  List.head <| List.filter (\s -> s.fips_code == fips) states


findById : List UsState -> Int -> Maybe UsState
findById states id =
  List.head <| List.filter (\s -> s.id == id) states
