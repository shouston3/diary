module Home exposing (..)

import Html exposing (Html, text, div, h1)


main
    = Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subcriptions
    }

type alias Todo =
    { title : String
    , description : String
    }


type alias Date =
    { diary : String
    , todos : List Todo
    }


type alias Model = String
    -- { loading : Bool
    -- , dates : Date
    -- }

initialModel : Model
initialModel = "Hello"

init : ( Model, Cmd Msg )
init = ( "Hello", Cmd.none )

view : Model -> Html Msg
view model =
    div [] [
        h1 [] [ text model ]
        ]

type Msg = M

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = ( model, Cmd.none )

subcriptions : Model -> Sub Msg
subcriptions model = Sub.none
