import Html exposing (..)
import Html.App as App
import Triomino
import Grid
import View
import Control
import Time exposing (Time, second)

main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

-- MODEL

type alias Model =
    { grid : Grid.Grid
    , solutions : List Triomino.Triomino
    }


init : (Model, Cmd Msg)
init =
    ({grid = Grid.grid 2 9, solutions = []}, Cmd.none)


-- UPDATE

type Msg
    = Tick Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick _ ->
            (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ text (toString model.grid) ]
