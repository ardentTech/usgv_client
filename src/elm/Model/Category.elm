module Model.Category exposing (Category(..), categories)


type Category = Incidents | Injured | Killed | Victims


categories : List Category
categories = [ Incidents, Injured, Killed, Victims ]
