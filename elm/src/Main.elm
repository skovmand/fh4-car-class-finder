module Main exposing (main)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onInput)


main : Program () Car Msg
main =
    Browser.sandbox { init = initial_car, update = update, view = view }



-- INIT


type CarClass
    = ClassX
    | ClassS2
    | ClassS1
    | ClassA
    | ClassB
    | ClassC
    | ClassD


type alias Car =
    { score : Int, class : CarClass }


initial_car : Car
initial_car =
    Car 800 ClassA



-- UPDATE


type Msg
    = Change String


update : Msg -> Car -> Car
update msg _ =
    case msg of
        Change newValue ->
            case String.toInt newValue of
                Just score ->
                    scoreToCar score

                Nothing ->
                    scoreToCar 800


scoreToCar : Int -> Car
scoreToCar score =
    if score > 700 && score <= 800 then
        Car score ClassA

    else
        Car score ClassX



-- VIEW


view : Car -> Html Msg
view model =
    div [ class "py-8" ]
        [ carClassView model
        , sliderView
        ]


carClassView : Car -> Html Msg
carClassView car =
    let
        carLetter =
            case car.class of
                ClassX ->
                    "X"

                ClassS2 ->
                    "S2"

                ClassS1 ->
                    "S1"

                ClassA ->
                    "A"

                ClassB ->
                    "B"

                ClassC ->
                    "C"

                ClassD ->
                    "D"

        carCssClass =
            case car.class of
                ClassX ->
                    "car-class-x"

                ClassS2 ->
                    "car-class-s2"

                ClassS1 ->
                    "car-class-s1"

                ClassA ->
                    "car-class-a"

                ClassB ->
                    "car-class-b"

                ClassC ->
                    "car-class-c"

                ClassD ->
                    "car-class-d"
    in
    div [ class ("mt-12 car-spec-container " ++ carCssClass) ]
        [ div [ class "car-class-container" ]
            [ div [ class "car-class" ] [ text carLetter ] ]
        , div [ class "car-score-container" ]
            [ div [ class "car-score" ] [ text (.score car |> String.fromInt) ] ]
        ]


sliderView : Html Msg
sliderView =
    div [ class "py-8 mx-auto flex" ]
        [ div [ class "mx-auto flex-1" ] []
        , div [ class "py-4 flex-1" ] [ input [ class "w-full", Html.Attributes.type_ "range", Html.Attributes.min "100", Html.Attributes.max "999", Html.Attributes.value "800", onInput Change ] [] ]
        , div [ class "mx-auto flex-1" ] []
        ]
