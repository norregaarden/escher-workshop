module Main exposing (main)

import Box exposing (..)
import Figure exposing (george)
import Fishy exposing (fishShapes)
import Fitting exposing (createPicture)
import Html exposing (..)
import Html.Attributes exposing (..)
import Letter exposing (..)
import Picture as P exposing (..)
import Rendering exposing (..)
import Svg exposing (Svg)


placeInsideDiv : Svg msg -> Html msg
placeInsideDiv svg =
    div [ style "padding" "50px" ] [ svg ]


main : Svg msg
main =
    let
        box =
            { a = { x = 125.0, y = 75.0 }
            , b = { x = 250.0, y = 0.0 }
            , c = { x = 0.0, y = 250.0 }
            }

        ( l, r ) =
            splitHorizontally 1 1 box

        ( lt, lb ) =
            splitVertically 1 1 l

        ( rt, rb ) =
            splitVertically 1 1 r

        g =
            createPicture george

        qg =
            quartet g ((flip << P.turns 2) g) (g |> P.turns 2) (g |> flip)

        hqg =
            quartet qg blank blank qg

        henderson p =
            nonet (createPicture hLetter)
                (createPicture eLetter)
                (createPicture nLetter)
                (createPicture dLetter)
                p
                (createPicture rLetter)
                (createPicture sLetter)
                (createPicture oLetter)
                (createPicture nLetter)
    in
    box
        |> times 3 henderson (createPicture eLetter)
        --|> quartet hqg hqg hqg hqg
        --|> qg
        --|> createPicture george
        --|> createPicture george
        --|> ontop g (flip g)
        --|> (turn <| aboveRatio 2 1 (toss g) (flip g))
        --|> toss g
        --|> (flip >> turn) g
        --|> (g |> flip |> turn)
        --|> (createPicture george |> P.turns 4)
        --|> (createPicture george |> turn |> turn |> turn |> turn)
        |> toSvgWithBoxes ( 500, 500 )
            [ box ]
        -- [ lt
        -- , rt |> flipBox |> turnBox |> turnBox
        -- , lb |> turnBox |> turnBox
        -- , rb |> flipBox
        -- ]
        |> placeInsideDiv
