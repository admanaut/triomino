module TriominoColor exposing (..)

import Color exposing (..)

type TriominoColor = Red | Orange | Yellow | Green | Blue | Violet | White

toInt : TriominoColor -> Int
toInt c =
    case c of
        Red -> 1
        Orange -> 2
        Yellow -> 3
        Green -> 4
        Blue -> 5
        Violet -> 6
        _ -> 0

fromInt : Int -> TriominoColor
fromInt i =
    case i of
        1 -> Red
        2 -> Orange
        3 -> Yellow
        4 -> Green
        5 -> Blue
        6 -> Violet
        _ -> White

toColor : TriominoColor -> Color
toColor c =
    case c of
        Red -> red
        Orange -> orange
        Yellow -> yellow
        Green -> green
        Blue -> blue
        Violet -> purple
        White -> white

toString : TriominoColor -> String
toString c =
    case c of
        Red -> "red"
        Orange -> "orange"
        Yellow -> "yellow"
        Green -> "green"
        Blue -> "blue"
        Violet -> "purple"
        White -> "white"
