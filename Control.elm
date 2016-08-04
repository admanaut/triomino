module Control exposing (..)

import Grid exposing (..)
import Grid
import Triomino exposing (..)
import TriominoColor exposing (..)
import TriominoColor

type alias Options = List (Triomino, TriominoColor)
type alias Solutions = List Triomino

options : Options
options = [ (straight, Red)
          , (line, Orange)
          , (tright, Yellow)
          , (tleft, Green)
          , (lright, Blue)
          , (lleft, Violet) ]

--solve' : Grid -> Options -> List Triomino -> List Triomino
solve' : Grid -> Options -> List Triomino -> Grid
solve' gr opts choices =
    if Grid.full gr then
        -- remember solution and backtrack
        -- choices
        gr
    else
        -- check each combination
        case opts of
            (o, color)::os ->
                case Grid.fit o gr of
                    Just fitTr ->
                        solve' (Grid.update fitTr (TriominoColor.toInt color)  gr) opts (List.append choices [fitTr])

                    Nothing ->
                        solve' gr os choices

            --[] -> choices
            [] -> gr

--solve : Grid -> List Triomino
solve : Grid -> Grid
solve gr =
    solve' gr options []
