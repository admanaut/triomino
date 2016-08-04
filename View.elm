module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Array
import Grid exposing (..)
import TriominoColor
import Color

genGrid gr =
    let
        toColor = (\ i ->
                       TriominoColor.toString <| TriominoColor.fromInt i)
        tableStyle = []
        collStyle = []
        cellStyle = (\ c ->
                         [ style [("border", "1px solid"),
                                      ("padding", "10px"),
                                      ("text-alligh", "center"),
                                      ("background-color", toColor c)] ]
                         )
        rows = (\r ->
                    Array.toList ( (Array.map (\c -> td (cellStyle c) [ ]) r) ))

        colls = (\g ->
                      Array.toList ( (Array.map (\c -> tr collStyle (rows c)) g) ))

    in
        table []
            (colls gr)
