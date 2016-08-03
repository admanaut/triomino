module Grid

import Triomino exposing (..)
import Triomino
import Location exposing (..)
import Array

type alias Grid = Array.Array (Array.Array Int)

-- Returns a Grid of n*m elements initialised with 0.
grid : Int -> Int -> Grid
grid n m =
    Array.repeat n (Array.repeat m 0)

filter : (Int -> Bool) -> Grid -> Grid
filter pred gr =
    Array.map (Array.filter f) gr


length : Grid -> Int
length gr =
    Array.foldr (+) 0 <| Array.map Array.length gr


get : Location -> Grid -> Maybe Int
get (lx, ly) gr =
    case Array.get lx gr of
        Just xs -> Array.get ly xs
        Nothing -> Nothing


-- Check if the grid is full.
full : Grid -> Bool
full gr =
    lenght gr == length <| filter ((==) 1) gr


-- Shift triomino to the location.
shift : Location -> Triomino -> Triomino
shift (offx, offy) tr =
    Triomino.map (\ (lx, ly) -> (lx + offx, ly + offy) ) tr

canFit : Grid -> Triomino -> Bool
canFit gr (x, y, z) =
    let
        locav = (\loc ->
                     case get loc gr of
                         Just v -> if v == 0 then True else False
                         Nothing -> False)
    in
        List.foldr (&&) True <| List.map (locav gr) [x, y, z]


-- Return the next available position where a triomino pottentially can fit.
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
        pottentials = List.map avPos <| Array.toIndexedList gr
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


-- Try to fit triomino in the grid
fit : Grid -> Triomino -> Maybe Grid
fit gr tr =
    case nextAvailable gr of
        Just loc ->
            let
                newloc = (shift tr loc)
            in
                if canFit gr newloc then
                    Just (add gr newloc)
                else
                    Nothing

        Nothing -> Nothing


-- TODO: remove this function as it's redundant
fitLocation : Grid -> Triomino -> Maybe Triomino
fitLocation gr tr =
    case nextAvailable gr of
        Just loc ->
            let
                newloc = (shift tr loc)
            in
                if canFit gr newloc then
                    Just newloc
                else
                    Nothing

        Nothing -> Nothing
