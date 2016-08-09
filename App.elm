import Html exposing (..)
import Html.App as App
import Triomino
import Grid
import View
import Control
import Time exposing (Time, second)
import Debug
import Array

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
    , solutions : List Grid.Grid
    }


init : (Model, Cmd Msg)
init =
    let
        gr = Grid.grid 2 9
        sols = [Control.solve gr]
    in
        case sols of
            s::ss ->
                ({grid = s, solutions = ss}, Cmd.none)

            [] ->
                ({grid = gr, solutions = []}, Cmd.none)

-- UPDATE

type Msg
    = Tick Time

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Tick _ ->
            case model.solutions of
                s::ss ->
                    ( {grid = s, solutions = ss }, Cmd.none)

                [] ->
                    init

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick


-- VIEW

view : Model -> Html Msg
view model =
    View.genGrid model.grid
    --div []
    --    [ text (toString model.grid) ]
