import Html exposing (..)
import Html.App as Html
import Triomino

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

-- type alias Model = String

--model : Triomino
model =
  Triomino.test

-- UPDATE

--type alias Msg = String

--update : Msg -> Model -> Model
update msg model = model


-- VIEW

--view : Model -> Html Msg
view model =
  div []
    [ text (toString model) ]
