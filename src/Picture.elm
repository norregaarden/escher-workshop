module Picture exposing (..)

import Box exposing (..)
import Shape exposing (..)
import Style exposing (..)


type alias Rendering =
    List ( Shape, Style )


type alias Picture =
    Box -> Rendering


type alias Transformation =
    Picture -> Picture


type alias Composition =
    Picture -> Picture -> Picture


blank : Picture
blank _ =
    []



-- Exercise 1


turn : Transformation
turn p =
    turnBox >> p



-- Entirely optional bonus exercise:


times : Int -> (a -> a) -> (a -> a)
times n fn =
    if n <= 0 then
        identity

    else
        fn >> times (n - 1) fn


turns : Int -> Transformation
turns n =
    times n turn



-- Exercise 2


flip : Transformation
flip p =
    flipBox >> p



-- Exercise 3


toss : Transformation
toss p =
    tossBox >> p



-- Exercise 4


aboveRatio : Int -> Int -> Composition
aboveRatio m n p1 p2 =
    \box ->
        let
            ( top, bot ) =
                splitVertically m n box
        in
        (top |> p1) ++ (bot |> p2)


above : Composition
above p1 p2 =
    aboveRatio 1 1 p1 p2


ontop : Composition
ontop p1 p2 =
    \box -> p1 box ++ p2 box



-- Exercise 5


besideRatio : Int -> Int -> Picture -> Picture -> Picture
besideRatio m n p1 p2 =
    \box ->
        let
            ( left, right ) =
                splitHorizontally m n box
        in
        (left |> p1) ++ (right |> p2)


beside : Picture -> Picture -> Picture
beside p1 p2 =
    besideRatio 1 1 p1 p2



-- Exercise 6


quartet : Picture -> Picture -> Picture -> Picture -> Picture
quartet nw ne sw se =
    beside (above nw sw) (above ne se)



-- Exercise 7


nonet : Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> Picture
nonet nw nm ne mw mm me sw sm se =
    besideRatio 1
        2
        (aboveRatio 1 2 nw (aboveRatio 1 1 mw sw))
        (besideRatio 1
            1
            (aboveRatio 1 2 nm (aboveRatio 1 1 mm sm))
            (aboveRatio 1 2 ne (aboveRatio 1 1 me se))
        )



-- Exercise 8


over : Picture -> Picture -> Picture
over =
    ontop



-- Exercise 9


ttile : Picture -> Picture
ttile fish =
    over fish (over (fish |> toss |> flip) (fish |> toss |> flip |> turns 3))



-- Exercise 10


utile : Picture -> Picture
utile fish =
    let
        north =
            fish |> toss |> flip

        west =
            turns 1 north

        south =
            turns 2 north

        east =
            turns 3 north
    in
    over north (over west (over south east))



-- Exercise 11


side : Int -> Picture -> Picture
side n fish =
    if n <= 0 then
        blank

    else
        quartet (side (n - 1) fish) (side (n - 1) fish) (turn (ttile fish)) (ttile fish)



-- turn side
-- oside : Int -> Picture -> Picture
-- oside n fish =
--     if n <= 0 then
--         blank
--     else
--         quartet (oside (n - 1) fish) fish (oside (n - 1) fish) fish
-- Exercise 12


corner : Int -> Picture -> Picture
corner n fish =
    if n <= 0 then
        blank

    else
        quartet
            (corner (n - 1) fish)
            (side (n - 1) fish)
            (turn (side (n - 1) fish))
            (utile fish)



-- Exercise 13


squareLimit : Int -> Picture -> Picture
squareLimit n fish =
    if n <= 0 then
        blank

    else
        nonet
            (corner n fish)
            (side n fish)
            (turns 3 (corner n fish))
            (turns 1 (side n fish))
            (utile fish)
            (turns 3 (side n fish))
            (turns 1 (corner n fish))
            (turns 2 (side n fish))
            (turns 2 (corner n fish))
