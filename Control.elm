module Control exposing (..)

import Grid
import Grid exposing (..)
import Triomino exposing (..)
import TriominoColor
import TriominoColor exposing (..)

type alias Options = List (Triomino, TriominoColor)
type alias Solutions = List Triomino

options : Options
options = [ (straight, Red)
          , (line, Orange)
          , (tright, Yellow)
          , (tleft, Green)
          , (lright, Blue)
          , (lleft, Violet) ]

solve' : Grid -> Options -> Options -> Maybe Grid
solve' gr opts allopts =
    if Grid.full gr then
         Just gr
    else
        case opts of
            (o, color)::os ->
                case Grid.fit o gr of
                    Just fitTr ->
                         let
                             val =  TriominoColor.toInt color
                             newgr = Grid.update fitTr val gr
                             solved = solve' newgr allopts allopts
                         in
                             case solved of
                                 Just sol ->
                                     Just sol

                                 Nothing ->
                                     solve' gr os allopts

                    Nothing ->
                        solve' gr os allopts

            [] ->
                Nothing


solve : Grid -> Grid
solve gr =
    case solve' gr options options of
        Just sol -> sol
        Nothing -> gr
