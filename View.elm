module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Array
import Grid exposing (..)

--genGrid : Grid -> Html
genGrid gr =
    let
        tableStyle = []
        collStyle = []
        cellStyle = [ style [("border", "1px solid"),
                             ("padding", "10px"),
                             ("text-alligh", "center")] ]

        rows = (\r ->
                    Array.toList ( (Array.map (\c -> td cellStyle [ text (toString c) ]) r) ))

        colls = (\g ->
                      Array.toList ( (Array.map (\c -> tr collStyle (rows c)) g) ))

    in
        table []
            (colls gr)
