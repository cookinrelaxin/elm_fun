import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
import Char

main = Html.beginnerProgram {model = model, view = view, update = update }

-- MODEL 

type alias Model =
    { name : String
    , password : String
    , passwordConfirmation : String
    }

model : Model
model = Model "" "" ""

-- UPDATE

type Msg
    = Name String
    | Password String
    | PasswordConfirmation String

update : Msg -> Model -> Model

update action model =
    case action of
        Name name ->
            {model | name = name}
        Password password ->
            {model | password = password}
        PasswordConfirmation passwordConfirmation ->
            {model | passwordConfirmation = passwordConfirmation}

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ input [type' "text", placeholder "Name", onInput Name] []
        , input [type' "password", placeholder "Password", onInput Password] []
        , input [type' "password", placeholder "Re-enter password", onInput PasswordConfirmation] []
        , viewValidation model
        ]

viewValidation : Model -> Html Msg
viewValidation model =
    let
        (color, message) =
            if model.password == model.passwordConfirmation then
                if String.length(model.password) > 8 then
                    if
                        String.any(Char.isUpper)(model.password) &&
                        String.any(Char.isLower)(model.password) &&
                        String.any(Char.isDigit)(model.password) then
                            ("green", "OK")
                    else
                        ("red", "Password must contain both upper case, lower case, and numeric characters")
                else
                    ("red", "Password must be longer than 8 characters")
            else
                ("red", "Passwords do not match!")
    in
        div [style [("color", color)]] [text message]
                

