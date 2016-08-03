module TriominoColor

import Color

type TriominoColor = Red | Orange | Yellow | Green | Blue | Violet

toColor : TriominoColor -> Color
toColor c =
    case c of
        Red -> red
        Orange -> orange
        Yellow -> yellow
        Green -> green
        Blue -> blue
        Violet -> purple
