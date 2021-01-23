module Main exposing (main)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (class, id, max, min, type_, value)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = initial_score, update = update, view = view }



-- INIT


type alias Model =
    Int


initial_score : Model
initial_score =
    800



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg _ =
    case msg of
        Change newValue ->
            case String.toInt newValue of
                Just int ->
                    int

                Nothing ->
                    800



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "py-8" ]
        [ carClassView model
        , sliderView
        ]


carClassView : Model -> Html Msg
carClassView score =
    let
        carScoreToClass =
            if score > 700 && score <= 800 then
                "A"

            else
                "?"
    in
    div [ class "mt-12 car-spec-container car-class-x" ]
        [ div [ class "car-class-container" ]
            [ div [ class "car-class" ] [ text carScoreToClass ] ]
        , div [ class "car-score-container" ]
            [ div [ class "car-score" ] [ text (String.fromInt score) ] ]
        ]


sliderView : Html Msg
sliderView =
    div [ class "py-8 mx-auto flex" ]
        [ div [ class "mx-auto flex-1" ] []
        , div [ class "py-4 flex-1" ] [ input [ class "w-full", Html.Attributes.type_ "range", Html.Attributes.min "100", Html.Attributes.max "999", Html.Attributes.value "800", onInput Change ] [] ]
        , div [ class "mx-auto flex-1" ] []
        ]
