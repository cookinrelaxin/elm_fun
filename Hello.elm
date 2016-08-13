import Html exposing (text)

main = text (toString (add 3 5))

add : Int -> Int -> Int
add x y = x + y
