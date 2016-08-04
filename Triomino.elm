module Triomino exposing (..)

import Location exposing (..)

type alias Triomino = (Location, Location, Location)

-- A straight shaped Triomino
-- *
-- *
-- *
straight : Triomino
straight = ( (0, 0),
             (0, 1),
             (0, 2) )

-- A line shaped Triomino
-- * * *
line : Triomino
line = ( (0, 0), (1, 0), (2, 0) )

-- A half-right T shaped Triomino
-- * *
-- *
tright : Triomino
tright = ( (0, 0), (1, 0),
           (0, 1) )

-- A half-left T shaped Triomino
-- * *
--   *
tleft : Triomino
tleft = ( (0, 0), (1, 0),
                  (1, 1) )

-- A L shaped Triomino
-- *
-- * *
lleft : Triomino
lleft =  (         (1, 0),
           (0, 1), (1, 1) )

-- A J shaped Triomino
--   *
-- * *
lright : Triomino
lright =  ( (0, 0),
            (0, 1), (1, 1) )

map : (Location -> Location) -> Triomino -> Triomino
map f (l1, l2, l3) =
    (f l1, f l2, f l3)
