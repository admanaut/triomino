import Html exposing (..)
import Html.App as Html
import Triomino exposing (..)
import Grid exposing (..)
import View exposing (..)
import Control exposing (..)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model =
    { grid : Grid
    , solutions : List List Triomino
    }

model : Model
model =
    { grid = Grid.grid 0 0
    , solutions = []
    }

-- UPDATE

type alias Msg = String

update : Msg -> Model -> Model
update msg model =
    {model | grid = Control.solve model.grid }


--render model =
    -- generate grid
    -- generate controls


-- VIEW

view : Model -> Html Msg
view model =
    View.genGrid model.grid
