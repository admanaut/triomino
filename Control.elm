module Control exposing (..)

import Grid exposing (..)
import Grid

import Triomino exposing (..)
import Array

type alias Options = List Triomino
type alias Solutions = List Triomino

options : Options
options = [ straight, line, tright, tleft, lright, lleft ]

solve' : Grid -> Options -> List Triomino -> List Triomino
solve' gr opts choices =
    if Grid.full gr then
        -- remember solution and backtrack
        choices
    else
        -- check each combination
        case opts of
            o::os ->
                case Grid.fit o gr of
                    Just fitTr ->
                        solve' (Grid.update fitTr 1 gr) opts (List.append choices [fitTr])

                    Nothing ->
                        solve' gr os choices

            [] -> choices

solve : Grid -> List Triomino
solve gr =
    solve' gr options []
