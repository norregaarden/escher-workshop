module Box exposing (..)

import Vector exposing (..)


type alias Box =
    { a : Vector
    , b : Vector
    , c : Vector
    }



-- Exercise 1


turnBox : Box -> Box
turnBox { a, b, c } =
    { a = add a b
    , b = c
    , c = neg b
    }



-- Exercise 2


flipBox : Box -> Box
flipBox { a, b, c } =
    { a = add a b
    , b = neg b
    , c = c
    }



-- Exercise 3


tossBox : Box -> Box
tossBox { a, b, c } =
    { a = add c b |> scale 0.5 |> add a
    , b = add c b |> scale 0.5
    , c = sub c b |> scale 0.5
    }



-- Exercise 4: above


splitVertically : Int -> Int -> Box -> ( Box, Box )
splitVertically m n { a, b, c } =
    let
        total =
            toFloat (m + n)

        topR =
            toFloat m / total

        botR =
            toFloat n / total
    in
    ( { a = add a (scale botR c)
      , b = b
      , c = scale topR c
      }
    , { a = a
      , b = b
      , c = scale botR c
      }
    )



-- Exercise 5: beside


splitHorizontally : Int -> Int -> Box -> ( Box, Box )
splitHorizontally m n { a, b, c } =
    let
        total =
            toFloat (m + n)

        leftR =
            toFloat m / total

        rightR =
            toFloat n / total
    in
    ( { a = a
      , b = scale leftR b
      , c = c
      }
    , { a = add a (scale leftR b)
      , b = scale rightR b
      , c = c
      }
    )
