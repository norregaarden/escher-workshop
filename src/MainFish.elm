module MainFish exposing (..)

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
            { a = { x = 50.0, y = 50.0 }
            , b = { x = 500.0, y = 0.0 }
            , c = { x = 0.0, y = 500.0 }
            }

        fish =
            createPicture fishShapes
    in
    box
        |> squareLimit 4 fish
        --|> squareLimit 4 (P.turns 2 (createPicture george))
        --|> corner 3 fish
        --|> side 3 fish
        --|> utile fish
        --|> ttile fish
        |> toSvgWithBoxes ( 600, 600 )
            []
        -- [ box
        -- , box |> flipBox |> tossBox
        -- ]
        |> placeInsideDiv
