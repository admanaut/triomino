module Control exposing (..)

import Grid exposing (..)
import Triomino exposing (..)
import Array

type alias Options = List Triomino
type alias Solutions = List Triomino

options : Options
options = [ straight, line, tright, tleft, lright, lleft ]

solve' : Grid -> Options -> List Triomino -> List Triomino
solve' gr opts choices =
    if full gr then
        -- remember solution and backtrack
        choices
    else
        -- check each combination
        case opts of
            o::os ->
                -- case fit gr o
                case fitLocation gr o of
                    Just loc ->
                        solve' (add gr loc) os (List.append choices [loc])

                    Nothing ->
                        solve' gr os choices

            [] -> choices

solve : Grid -> List Triomino
solve gr =
    solve' gr options []
