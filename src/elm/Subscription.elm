module Subscription exposing (subscriptions)

import D3 exposing (stateClicked)
import Message exposing (Msg(UsStateClicked))
import Model exposing (Model)


subscriptions : Model -> Sub Msg
subscriptions model = stateClicked UsStateClicked
