module Grid exposing (..)

import Triomino exposing (..)
import Triomino
import Location exposing (..)
import Array

type alias Grid = Array.Array (Array.Array Int)

grid : Int -> Int -> Grid
grid n m =
    Array.repeat n (Array.repeat m 0)

filter : (Int -> Bool) -> Grid -> Grid
filter pred gr =
    Array.map (Array.filter pred) gr


length : Grid -> Int
length gr =
    Array.foldr (+) 0 <| Array.map Array.length gr


get : Location -> Grid -> Maybe Int
get (lx, ly) gr =
    case Array.get lx gr of
        Just xs -> Array.get ly xs
        Nothing -> Nothing

set : Location -> Int -> Grid -> Grid
set (lx, ly) v gr =
    case Array.get lx gr of
        Just ys ->
            case Array.get ly ys of
                Just _ -> Array.set lx (Array.set ly v ys) gr
                Nothing -> gr
        Nothing -> gr

full : Grid -> Bool
full gr =
     length gr == (length <| filter ((<) 0) gr)

-- rename it to translate
shift : Location -> Triomino -> Triomino
shift (offx, offy) ((xx, xy), (yx, yy), (zx, zy)  ) =
    ( (offx, offy), (offx + yx, yy - xy + offy), (offx + zx, zy - xy + offy)  )


canFit : Triomino -> Grid ->  Bool
canFit (x, y, z) gr =
    let
        locav = (\loc ->
                     case get loc gr of
                         Just v -> if v == 0 then True else False
                         Nothing -> False)
    in
        List.foldr (&&) True <| List.map locav [x, y, z]



-- Returns a list of all available locations where a triomino can pottentially fit.
availableLoc : Grid -> List Location
availableLoc gr =
    let
        zip = List.map2 (,)
        avPos = (\ (idx, col) ->
                     let
                         collst = Array.toIndexedList col
                         free = List.map fst <| List.filter (\loc -> snd loc == 0) collst
                         idxs = List.repeat (List.length free) idx
                     in
                         zip idxs free
                )
    in
        List.concatMap avPos <| Array.toIndexedList gr


update : Triomino -> Int -> Grid -> Grid
update (x, y, z) v gr =
    set z v (set y v (set x v gr))

-- Try to fit triomino in the grid.
fit : Triomino -> Grid -> Maybe Triomino
fit tr gr =
    let
        allav = availableLoc gr
        -- fitrec : List Location -> Maybe Triomino
        fitrec = (\ avloclst ->
                      case avloclst of
                          loc::rstloc ->
                              let
                                  shiftedTr = shift loc tr
                              in
                                  if canFit shiftedTr gr then
                                      Just shiftedTr
                                  else
                                      fitrec rstloc
                          [] -> Nothing
                 )
    in
        fitrec allav
