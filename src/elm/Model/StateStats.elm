module Model.StateStats exposing (StateStats, forYear)


type alias StateStats = {
  incidents : Int,
  injured : Int,
  killed : Int,
  state : Int,
  victims : Int,
  year : Int
}


forYear : List StateStats -> Int -> List StateStats
forYear stats year =
  List.filter ( \s -> s.year == year ) stats
