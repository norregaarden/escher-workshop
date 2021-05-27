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
over p1 p2 =
    blank



-- Exercise 9


ttile : Picture -> Picture
ttile fish =
    blank



-- Exercise 10


utile : Picture -> Picture
utile fish =
    blank



-- Exercise 11


side : Int -> Picture -> Picture
side n fish =
    blank



-- Exercise 12


corner : Int -> Picture -> Picture
corner n fish =
    blank



-- Exercise 13


squareLimit : Int -> Picture -> Picture
squareLimit n fish =
    blank
