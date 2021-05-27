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
            { a = { x = 125.0, y = 75.0 }
            , b = { x = 250.0, y = 0.0 }
            , c = { x = 0.0, y = 250.0 }
            }

        fish =
            createPicture fishShapes
    in
    box
        |> fish
        |> toSvgWithBoxes ( 500, 500 )
            [ box ]
        |> placeInsideDiv
