module Triomino exposing (..)

import Array

type alias Grid = Array.Array (Array.Array Int)
type alias Location = (Int, Int)
type alias Triomino = (Location, Location, Location)
type alias Options = List Triomino
type alias Solutions = List Triomino

-- Returns a Grid of n*m elements initialised with 0.
grid : Int -> Int -> Grid
grid n m =
    Array.repeat n (Array.repeat m 0)

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

options : Options
options = [ straight, line, tright, tleft, lright, lleft ]


shift : Triomino -> (Int, Int) -> Triomino
shift  ( (x0, x1), (y0, y1), (z0, z1) ) (x, y) =
    ( (x0 + x, x1 + y), (y0 + x, y1 + y), (z0 + x, z1 + y) )

canFitLocation : Grid -> Location -> Bool
canFitLocation gr (l0, l1) =
    case Array.get l0 gr of
        Just xs ->
            case Array.get l1 xs of
                Just v -> if v == 0 then True else False
                Nothing -> False
        Nothing -> False

canFit : Grid -> Triomino -> Bool
canFit gr (x, y, z) =

    List.foldr (&&) True ( List.map (canFitLocation gr) [x, y, z] )

setLocation : Grid -> Location -> Grid
setLocation gr (l0, l1) =
    case Array.get l0 gr of
        Just xs ->
            case Array.get l1 xs of
                Just v -> Array.set l0 (Array.set l1 1 xs) gr
                Nothing -> gr
        Nothing -> gr

-- Add Triomino to the grid
add : Grid -> Triomino -> Grid
add gr (x, y, z) =
    setLocation (setLocation (setLocation gr x) y) z

nextAvailable : Grid -> Maybe Location
nextAvailable gr =
    let
        avPos = (\ (idx, col) ->
                     let
                         collst = Array.toIndexedList col
                         free = List.filter (\loc -> snd loc == 0) collst
                     in
                         case List.head free of
                             Just h -> Just (idx, fst h)
                             Nothing -> Nothing
                )
        pottentials = List.map avPos (Array.toIndexedList gr)
        findrec = (\pot ->
                       case pot of
                           p::ps ->
                               case p of
                                   Just loc -> Just loc
                                   Nothing -> findrec ps
                           [] -> Nothing
                  )
    in
        findrec pottentials


-- Try to fit triomino in grid.
fit : Grid -> Triomino -> Maybe Grid
fit gr tr =
    case nextAvailable gr of
        Just loc ->
            Just ( add gr (shift tr loc) )
        Nothing -> Nothing

-- Check if the grid is full
full : Grid -> Bool
full gr =
    let
        colFull = (\c -> Array.length c == (Array.foldr (+) 0 c) )
    in
        Array.foldr (&&) True (Array.map colFull gr)

-- chooseNextFit : Grid -> Options -> Maybe Triomino


solve : Grid -> Options -> List Triomino -> Bool
solve gr opts choices =
    if full gr then
        --remember solution and backtrack
        True
    else
        -- check each combination
        case opts of
            o::os ->
                if canFit gr o then
                    solve gr os (List.append choices [o])
                else
                    solve gr os choices

            [] -> False


test =
    let
        gr = grid 2 9
    in
        -- canFit gr tright
        -- add gr (shift straight (1, 0))
        -- add gr tright
        -- add gr line
        -- full gr
        -- full (add gr straight)
        -- solve gr
        --shift tright (0, 2)
        -- nextAvailable (add gr straight)
        fit (add gr tright) straight


{-
solve : Grid -> Options -> Solutions
solve grid options =
-}
