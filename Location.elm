module Location exposing (..)

type alias Location = (Int, Int)

map : (Int -> Int) -> Location -> Location
map f (lx, ly) =
    (f lx, f ly)
