module Model.Stats exposing (Stats, forYear)


type alias Stats = {
  incidents : Int,
  injured : Int,
  killed : Int,
  state : Int,
  victims : Int,
  year : Int
}


forYear : List Stats -> Int -> List Stats
forYear stats year =
  List.filter ( \s -> s.year == year ) stats
