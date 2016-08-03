module Location

type Location = (Int, Int)

map : (Location -> Location) -> Location -> Location
map f (lx, ly) =
    (f lx, f ly)
