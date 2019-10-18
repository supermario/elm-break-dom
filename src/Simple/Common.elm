port module Simple.Common exposing (Model, Msg, init, main, noop, onUrlRequest, subscriptions, update, view)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Html exposing (Html, a, button, div, li, node, span, text, ul)
import Html.Attributes exposing (class, id, style, title)
import Html.Events exposing (onClick)
import Html.Keyed
import Html.Lazy exposing (lazy)
import Url


port event : String -> Cmd msg


port insertIntoBody : ( String, Int, Int ) -> Cmd msg


port insertBeforeTarget : String -> Cmd msg


port appendToTarget : String -> Cmd msg


port removeTarget : String -> Cmd msg


port wrapTarget : String -> Cmd msg


port updateAttribute : String -> Cmd msg


port removeInsertedNode : String -> Cmd msg


port done : (String -> msg) -> Sub msg


type Msg
    = NoOp
    | UrlRequest UrlRequest
    | Event String
    | InsertIntoBody Int Int String
    | InsertBeforeTarget String
    | AppendToTarget String
    | RemoveTarget String
    | WrapTarget String
    | UpdateAttribute String
    | RemoveInsertedNode String
    | Done String


onUrlRequest : UrlRequest -> Msg
onUrlRequest =
    UrlRequest


noop : Msg
noop =
    NoOp


type alias Model =
    Dict String Int


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Dict.empty, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UrlRequest urlRequest ->
            ( model
            , case urlRequest of
                Internal url ->
                    Nav.load (Url.toString url)

                External url ->
                    Nav.load url
            )

        Event s ->
            ( model, event s )

        InsertIntoBody top bottom id ->
            ( model, insertIntoBody ( id, top, bottom ) )

        InsertBeforeTarget id ->
            ( model, insertBeforeTarget id )

        AppendToTarget id ->
            ( model, appendToTarget id )

        RemoveTarget id ->
            ( model, removeTarget id )

        WrapTarget id ->
            ( model, wrapTarget id )

        UpdateAttribute id ->
            ( model, updateAttribute id )

        RemoveInsertedNode id ->
            ( model, removeInsertedNode id )

        Done id ->
            ( Dict.update id
                (\maybeCount ->
                    case maybeCount of
                        Just n ->
                            Just (n + 1)

                        Nothing ->
                            Just 1
                )
                model
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    done Done


view : Model -> Html Msg
view model =
    ul []
        [ insertIntoBody1 model
        , insertIntoBody2 model
        , insertIntoBody3 model
        , insertIntoBody4 model
        , insertIntoBody5 model
        , insertIntoBody6 model
        , insertIntoBody7 model
        , insertIntoBody8 model
        , insert1 model
        , insert2 model
        , insert3 model
        , insert4 model
        , insert5 model
        , insert6 model
        , insert7 model
        , insert8 model
        , insert9 model
        , insert10 model
        , insert11 model
        , insert12 model
        , insert13 model
        , insert14 model
        , insert15 model
        , insert16 model
        , insert17 model
        , insert18 model
        , insert19 model
        , insert20 model
        , insert21 model
        , insert22 model
        , insert23 model
        , insert24 model
        , insert25 model
        , insert26 model
        , insert27 model
        , insert28 model
        , append1 model
        , append2 model
        , append3 model
        , append4 model
        , append5 model
        , append6 model
        , append7 model
        , append8 model
        , append9 model
        , append10 model
        , append11 model
        , append12 model
        , remove1 model
        , remove2 model
        , remove3 model
        , remove4 model
        , remove5 model
        , wrap1 model
        , wrap2 model
        , wrap3 model
        , wrap4 model
        , wrap5 model
        , wrap6 model
        , wrap7 model
        , wrap8 model
        , wrap9 model
        , wrap10 model
        , wrap11 model
        , wrap12 model
        , wrap13 model
        , wrap14 model
        , wrap15 model
        , wrap16 model
        , wrap17 model
        , updateAttribute1 model
        , updateAttribute2 model
        , updateAttribute3 model
        , event1 model
        , event2 model
        , event3 model
        , event4 model
        , event5 model
        , event6 model
        , event7 model
        , event8 model
        , event9 model
        , event10 model
        , event11 model
        , event12 model
        , event13 model
        , event14 model
        , event15 model
        , event16 model
        , event17 model
        , event18 model
        , keyed1 model
        , keyed2 model
        , keyed3 model
        , keyed4 model
        , keyed5 model
        , keyed6 model
        , keyed7 model
        , keyed8 model
        , keyed9 model
        , keyed10 model
        , keyed11 model
        , keyed12 model
        , keyed13 model
        , keyed14 model
        , keyed15 model
        , keyed16 model
        , keyed17 model
        , keyed18 model
        , keyed19 model
        , keyed20 model
        , keyed21 model
        , keyed22 model
        , keyed23 model
        , keyed24 model
        , lazy1 model
        , lazy2 model
        , lazy3 model
        , lazy4 model
        , lazy5 model
        , lazy6 model
        , lazy7 model
        , lazy8 model
        , lazy9 model
        , lazy10 model
        , lazy11 model
        , lazy12 model
        , lazy13 model
        , lazy14 model
        , lazy15 model
        , lazy16 model
        , lazy17 model
        , lazy18 model
        , lazy19 model
        , lazy20 model
        ]



-- UTILS


wrap : Model -> (String -> Msg) -> String -> Html Msg -> Html Msg
wrap model toMsg id_ content =
    li
        [ id id_
        , class ("count-" ++ count id_ model)
        , style "padding" "20px"
        ]
        [ content
        , button
            [ onClick (toMsg id_)
            , class "break"
            ]
            [ text id_ ]
        , button
            [ onClick (RemoveInsertedNode id_)
            , class "remove-inserted-node"
            ]
            [ text id_ ]
        ]


beforeOrAfter : String -> Model -> String
beforeOrAfter id model =
    if Dict.member id model then
        "after"

    else
        "before"


count : String -> Model -> String
count id model =
    Dict.get id model
        |> Maybe.withDefault 0
        |> String.fromInt


viewText : String -> Html msg
viewText s =
    text s



-- INSERT INTO <body>


insertIntoBody1 : Model -> Html Msg
insertIntoBody1 model =
    wrap model (InsertIntoBody 0 0) "insert-into-body1" <|
        text (beforeOrAfter "insert-into-body1" model)


insertIntoBody2 : Model -> Html Msg
insertIntoBody2 model =
    wrap model (InsertIntoBody 0 1) "insert-into-body2" <|
        text (beforeOrAfter "insert-into-body2" model)


insertIntoBody3 : Model -> Html Msg
insertIntoBody3 model =
    wrap model (InsertIntoBody 0 2) "insert-into-body3" <|
        text (beforeOrAfter "insert-into-body3" model)


insertIntoBody4 : Model -> Html Msg
insertIntoBody4 model =
    wrap model (InsertIntoBody 1 0) "insert-into-body4" <|
        text (beforeOrAfter "insert-into-body4" model)


insertIntoBody5 : Model -> Html Msg
insertIntoBody5 model =
    wrap model (InsertIntoBody 1 1) "insert-into-body5" <|
        text (beforeOrAfter "insert-into-body5" model)


insertIntoBody6 : Model -> Html Msg
insertIntoBody6 model =
    wrap model (InsertIntoBody 1 2) "insert-into-body6" <|
        text (beforeOrAfter "insert-into-body6" model)


insertIntoBody7 : Model -> Html Msg
insertIntoBody7 model =
    wrap model (InsertIntoBody 2 0) "insert-into-body7" <|
        text (beforeOrAfter "insert-into-body7" model)


insertIntoBody8 : Model -> Html Msg
insertIntoBody8 model =
    wrap model (InsertIntoBody 2 1) "insert-into-body8" <|
        text (beforeOrAfter "insert-into-body8" model)



-- INSERT <div>EXTENSION NODE</div> BEFORE ".target"


insert1 : Model -> Html Msg
insert1 model =
    wrap model InsertBeforeTarget "insert1" <|
        div [] [ div [ class "target" ] [ div [] [ text (beforeOrAfter "insert1" model) ] ] ]


{-| Expected:

    <div>
        <div>EXTENSION NODE</div>
        <div class="target">after</div>
    </div>

Actual:

    <div>
        <div>after</div>
        <div class="target">before</div>
    </div>

-}
insert2 : Model -> Html Msg
insert2 model =
    wrap model InsertBeforeTarget "insert2" <|
        div [] [ div [ class "target" ] [ text (beforeOrAfter "insert2" model) ] ]


insert3 : Model -> Html Msg
insert3 model =
    wrap model InsertBeforeTarget "insert3" <|
        div [] [ div [ class "target" ] [], text (beforeOrAfter "insert3" model) ]


{-| Expected:

    <div>
        <div>EXTENSION NODE</div>
        <div class="target after"></div>
    </div>

Actual:

    <div>
        <div class="after">EXTENSION NODE</div>
        <div class="target before"></div>
    </div>

-}
insert4 : Model -> Html Msg
insert4 model =
    wrap model InsertBeforeTarget "insert4" <|
        div [] [ div [ class "target", class (beforeOrAfter "insert4" model) ] [] ]


insert5 : Model -> Html Msg
insert5 model =
    wrap model InsertBeforeTarget "insert5" <|
        div [] [ text (beforeOrAfter "insert5" model), div [ class "target" ] [] ]


insert6 : Model -> Html Msg
insert6 model =
    wrap model InsertBeforeTarget "insert6" <|
        div []
            [ if beforeOrAfter "insert6" model == "before" then
                text "1"

              else
                div [ class "e1" ] []
            , div [ class "target" ] []
            ]


insert7 : Model -> Html Msg
insert7 model =
    wrap model InsertBeforeTarget "insert7" <|
        div []
            [ if beforeOrAfter "insert7" model == "before" then
                div [ class "e1" ] []

              else
                text ""
            , div [ class "target" ] []
            ]


insert8 : Model -> Html Msg
insert8 model =
    wrap model InsertBeforeTarget "insert8" <|
        div []
            (if beforeOrAfter "insert8" model == "before" then
                [ div [ class "target" ] [] ]

             else
                []
            )


insert9 : Model -> Html Msg
insert9 model =
    wrap model InsertBeforeTarget "insert9" <|
        div []
            (if beforeOrAfter "insert9" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ text "", div [ class "target" ] [] ]
            )


insert10 : Model -> Html Msg
insert10 model =
    wrap model InsertBeforeTarget "insert10" <|
        div []
            (if beforeOrAfter "insert10" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ div [ class "e1" ] [], div [ class "target" ] [] ]
            )


insert11 : Model -> Html Msg
insert11 model =
    wrap model InsertBeforeTarget "insert11" <|
        div []
            (if beforeOrAfter "insert11" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ a [ class "e1" ] [], div [ class "target" ] [] ]
            )


insert12 : Model -> Html Msg
insert12 model =
    wrap model InsertBeforeTarget "insert12" <|
        div []
            (if beforeOrAfter "insert12" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ a [ class "e1" ] [] ]
            )


insert13 : Model -> Html Msg
insert13 model =
    wrap model InsertBeforeTarget "insert13" <|
        div []
            (if beforeOrAfter "insert13" model == "before" then
                [ div [ class "e1" ] [], div [ class "target" ] [] ]

             else
                [ div [ class "target" ] [] ]
            )


insert14 : Model -> Html Msg
insert14 model =
    wrap model InsertBeforeTarget "insert14" <|
        div []
            (if beforeOrAfter "insert14" model == "before" then
                [ a [ class "e1" ] [], div [ class "target" ] [] ]

             else
                [ div [ class "target" ] [] ]
            )


insert15 : Model -> Html Msg
insert15 model =
    wrap model InsertBeforeTarget "insert15" <|
        div []
            (if beforeOrAfter "insert15" model == "before" then
                [ text "", div [ class "target" ] [] ]

             else
                [ div [ class "target" ] [] ]
            )


insert16 : Model -> Html Msg
insert16 model =
    wrap model InsertBeforeTarget "insert16" <|
        div []
            (if beforeOrAfter "insert16" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ div [ class "target" ] [], text "" ]
            )


insert17 : Model -> Html Msg
insert17 model =
    wrap model InsertBeforeTarget "insert17" <|
        div []
            (if beforeOrAfter "insert17" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ div [ class "target" ] [], div [ class "e1" ] [] ]
            )


insert18 : Model -> Html Msg
insert18 model =
    wrap model InsertBeforeTarget "insert18" <|
        div []
            (if beforeOrAfter "insert18" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ div [ class "target" ] [], a [ class "e1" ] [] ]
            )


insert19 : Model -> Html Msg
insert19 model =
    wrap model InsertBeforeTarget "insert19" <|
        div []
            (if beforeOrAfter "insert19" model == "before" then
                [ div [ class "target" ] [], div [ class "e1" ] [] ]

             else
                [ div [ class "target" ] [] ]
            )


insert20 : Model -> Html Msg
insert20 model =
    wrap model InsertBeforeTarget "insert20" <|
        div []
            (if beforeOrAfter "insert20" model == "before" then
                [ div [ class "target" ] [], a [ class "e1" ] [] ]

             else
                [ div [ class "target" ] [] ]
            )


insert21 : Model -> Html Msg
insert21 model =
    wrap model InsertBeforeTarget "insert21" <|
        div []
            (if beforeOrAfter "insert21" model == "before" then
                [ div [ class "target" ] [], text "" ]

             else
                [ div [ class "target" ] [] ]
            )


insert22 : Model -> Html Msg
insert22 model =
    wrap model InsertBeforeTarget "insert22" <|
        Html.map identity <|
            div [] [ div [ class "target" ] [ text (beforeOrAfter "insert22" model) ] ]


insert23 : Model -> Html Msg
insert23 model =
    wrap model InsertBeforeTarget "insert23" <|
        Html.map identity <|
            div [] [ div [ class "target", class (beforeOrAfter "insert23" model) ] [] ]


insert24 : Model -> Html Msg
insert24 model =
    wrap model InsertBeforeTarget "insert24" <|
        div []
            [ Html.map identity <|
                div [ class "target", class (beforeOrAfter "insert24" model) ] []
            ]


insert25 : Model -> Html Msg
insert25 model =
    wrap model InsertBeforeTarget "insert25" <|
        div []
            [ Html.map identity <|
                div [ class "target" ] []
            , text (beforeOrAfter "insert25" model)
            ]


insert26 : Model -> Html Msg
insert26 model =
    wrap model InsertBeforeTarget "insert26" <|
        div []
            [ text (beforeOrAfter "insert26" model)
            , Html.map identity <|
                div [ class "target" ] []
            ]


insert27 : Model -> Html Msg
insert27 model =
    wrap model InsertBeforeTarget "insert27" <|
        div []
            [ Html.map identity (text "")
            , div [ class "target", class (beforeOrAfter "insert27" model) ] []
            ]


insert28 : Model -> Html Msg
insert28 model =
    wrap model InsertBeforeTarget "insert28" <|
        div []
            [ div [ class "target", class (beforeOrAfter "insert28" model) ] []
            , Html.map identity (text "")
            ]



-- APPEND TO ".target"


append1 : Model -> Html Msg
append1 model =
    wrap model AppendToTarget "append1" <|
        div [ class "target", class (beforeOrAfter "append1" model) ]
            []


append2 : Model -> Html Msg
append2 model =
    wrap model AppendToTarget "append2" <|
        div [ class "target" ]
            [ text (beforeOrAfter "append2" model) ]


append3 : Model -> Html Msg
append3 model =
    wrap model AppendToTarget "append3" <|
        div [ class "target" ]
            (if beforeOrAfter "append3" model == "before" then
                []

             else
                [ text "" ]
            )


append4 : Model -> Html Msg
append4 model =
    wrap model AppendToTarget "append4" <|
        div [ class "target" ]
            (if beforeOrAfter "append4" model == "before" then
                []

             else
                [ div [ class "e1" ] [ text "" ] ]
            )


append5 : Model -> Html Msg
append5 model =
    wrap model AppendToTarget "append5" <|
        div [ class "target" ]
            (if beforeOrAfter "append5" model == "before" then
                []

             else
                [ a [ class "e1" ] [ text "" ] ]
            )


append6 : Model -> Html Msg
append6 model =
    wrap model AppendToTarget "append6" <|
        div [ class "target" ]
            (if beforeOrAfter "append6" model == "before" then
                [ text "" ]

             else
                []
            )


append7 : Model -> Html Msg
append7 model =
    wrap model AppendToTarget "append7" <|
        div [ class "target" ]
            (if beforeOrAfter "append7" model == "before" then
                [ div [ class "e1" ] [ text "" ] ]

             else
                []
            )


append8 : Model -> Html Msg
append8 model =
    wrap model AppendToTarget "append8" <|
        div [ class "target" ]
            (if beforeOrAfter "append8" model == "before" then
                [ a [ class "e1" ] [ text "" ] ]

             else
                []
            )


append9 : Model -> Html Msg
append9 model =
    wrap model AppendToTarget "append9" <|
        div [ class "target" ]
            (if beforeOrAfter "append9" model == "before" then
                [ text "", text "" ]

             else
                []
            )


append10 : Model -> Html Msg
append10 model =
    wrap model AppendToTarget "append10" <|
        div [ class "target" ]
            (if beforeOrAfter "append10" model == "before" then
                [ div [ class "e1" ] [], div [ class "e2" ] [] ]

             else
                []
            )


append11 : Model -> Html Msg
append11 model =
    wrap model AppendToTarget "append11" <|
        div []
            (if beforeOrAfter "append11" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ text "" ]
            )


append12 : Model -> Html Msg
append12 model =
    wrap model AppendToTarget "append12" <|
        div []
            (if beforeOrAfter "append12" model == "before" then
                [ div [ class "target" ] [] ]

             else
                []
            )



-- REMOVE ".target"


remove1 : Model -> Html Msg
remove1 model =
    wrap model RemoveTarget "remove1" <|
        div [] [ div [ class "target" ] [ text (beforeOrAfter "remove1" model) ] ]


remove2 : Model -> Html Msg
remove2 model =
    wrap model RemoveTarget "remove2" <|
        div [] [ div [ class "target" ] [ div [] [ text (beforeOrAfter "remove2" model) ] ] ]


remove3 : Model -> Html Msg
remove3 model =
    wrap model RemoveTarget "remove3" <|
        div [] [ div [ class "target" ] [], text (beforeOrAfter "remove3" model) ]


remove4 : Model -> Html Msg
remove4 model =
    wrap model RemoveTarget "remove4" <|
        div [] [ div [ class "target", class (beforeOrAfter "remove4" model) ] [] ]


remove5 : Model -> Html Msg
remove5 model =
    wrap model RemoveTarget "remove5" <|
        div [] [ text (beforeOrAfter "remove5" model), div [ class "target" ] [] ]



-- WRAP ".target" into <font>


wrap1 : Model -> Html Msg
wrap1 model =
    wrap model WrapTarget "wrap1" <|
        div [] [ div [ class "target" ] [ text (beforeOrAfter "wrap1" model) ] ]


wrap2 : Model -> Html Msg
wrap2 model =
    wrap model WrapTarget "wrap2" <|
        div [] [ div [ class "target", class (beforeOrAfter "wrap2" model) ] [] ]


wrap3 : Model -> Html Msg
wrap3 model =
    wrap model WrapTarget "wrap3" <|
        div [] [ div [ class "target" ] [], text (beforeOrAfter "wrap3" model) ]


wrap4 : Model -> Html Msg
wrap4 model =
    wrap model WrapTarget "wrap4" <|
        div [] [ text (beforeOrAfter "wrap4" model), div [ class "target" ] [] ]


wrap5 : Model -> Html Msg
wrap5 model =
    wrap model WrapTarget "wrap5" <|
        div [] [ node "font" [ class "target" ] [ text (beforeOrAfter "wrap5" model) ] ]


{-| Expected:

    <font><font class="target after"></font></font>

or

    <font class="target after"></font>

Actual:

    <font class="target after"><font class="target before"></font></font>

-}
wrap6 : Model -> Html Msg
wrap6 model =
    wrap model WrapTarget "wrap6" <|
        div [] [ node "font" [ class "target", class (beforeOrAfter "wrap6" model) ] [] ]


wrap7 : Model -> Html Msg
wrap7 model =
    wrap model WrapTarget "wrap7" <|
        div [] [ node "font" [ class "target" ] [], text (beforeOrAfter "wrap7" model) ]


wrap8 : Model -> Html Msg
wrap8 model =
    wrap model WrapTarget "wrap8" <|
        div [] [ text (beforeOrAfter "wrap8" model), node "font" [ class "target" ] [] ]


wrap9 : Model -> Html Msg
wrap9 model =
    wrap model WrapTarget "wrap9" <|
        div []
            [ if beforeOrAfter "wrap9" model == "before" then
                div [ class "target" ] []

              else
                text ""
            ]


wrap10 : Model -> Html Msg
wrap10 model =
    wrap model WrapTarget "wrap10" <|
        div []
            [ if beforeOrAfter "wrap10" model == "before" then
                div [ class "target" ] []

              else
                a [ class "e1" ] []
            ]


wrap11 : Model -> Html Msg
wrap11 model =
    wrap model WrapTarget "wrap11" <|
        div []
            [ if beforeOrAfter "wrap11" model == "before" then
                div [ class "target" ] []

              else
                node "font" [ class "e1" ] [ text "" ]
            ]


wrap12 : Model -> Html Msg
wrap12 model =
    wrap model WrapTarget "wrap12" <|
        div []
            (if beforeOrAfter "wrap12" model == "before" then
                [ div [ class "target" ] [] ]

             else
                []
            )


wrap13 : Model -> Html Msg
wrap13 model =
    wrap model WrapTarget "wrap13" <|
        div []
            (if beforeOrAfter "wrap13" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ text "1", text "2" ]
            )


wrap14 : Model -> Html Msg
wrap14 model =
    wrap model WrapTarget "wrap14" <|
        div []
            (if beforeOrAfter "wrap14" model == "before" then
                [ div [ class "target" ] [] ]

             else
                [ a [ class "e1" ] []
                , a [ class "e2" ] []
                ]
            )


wrap15 : Model -> Html Msg
wrap15 model =
    wrap model WrapTarget "wrap15" <|
        div []
            (if beforeOrAfter "wrap15" model == "before" then
                [ div [ class "target", class "e1" ] [] ]

             else
                [ div [ class "target", class "e2" ] []
                , a [ class "e3" ] []
                ]
            )


wrap16 : Model -> Html Msg
wrap16 model =
    wrap model WrapTarget "wrap16" <|
        div []
            (if beforeOrAfter "wrap16" model == "before" then
                [ div [ class "target", class "e1" ] [] ]

             else
                [ a [ class "e3" ] []
                , div [ class "target", class "e2" ] []
                ]
            )


wrap17 : Model -> Html Msg
wrap17 model =
    wrap model WrapTarget "wrap17" <|
        div []
            (if beforeOrAfter "wrap17" model == "before" then
                [ div [ class "target", class "e1" ] [] ]

             else
                [ node "font" [ class "e3" ] []
                , div [ class "target", class "e2" ] []
                ]
            )



-- REPLACE title of ".target" WITH "break"


updateAttribute1 : Model -> Html Msg
updateAttribute1 model =
    wrap model UpdateAttribute "update-attribute1" <|
        div
            [ class "target"
            , class (beforeOrAfter "update-attribute1" model)
            ]
            [ text (beforeOrAfter "update-attribute1" model) ]


updateAttribute2 : Model -> Html Msg
updateAttribute2 model =
    wrap model UpdateAttribute "update-attribute2" <|
        div
            [ class "target"
            , title "hello"
            , class (beforeOrAfter "update-attribute2" model)
            ]
            [ text (beforeOrAfter "update-attribute2" model) ]


updateAttribute3 : Model -> Html Msg
updateAttribute3 model =
    wrap model UpdateAttribute "update-attribute3" <|
        div
            [ class "target"
            , title (beforeOrAfter "update-attribute3" model)
            , class (beforeOrAfter "update-attribute3" model)
            ]
            [ text (beforeOrAfter "update-attribute2" model) ]



-- EVENTS


event1 : Model -> Html Msg
event1 model =
    wrap model InsertBeforeTarget "event1" <|
        div []
            [ span
                [ class "target"
                , class "button"
                , onClick (Event "a")
                ]
                [ text (beforeOrAfter "event1" model) ]
            ]


event2 : Model -> Html Msg
event2 model =
    wrap model InsertBeforeTarget "event2" <|
        div []
            [ span
                [ class "target"
                , class "button"
                , Html.Attributes.map Event (onClick "a")
                ]
                [ text (beforeOrAfter "event2" model) ]
            ]


event3 : Model -> Html Msg
event3 model =
    wrap model InsertBeforeTarget "event3" <|
        div []
            [ Html.map Event <|
                span
                    [ class "target"
                    , class "button"
                    , onClick "a"
                    ]
                    [ text (beforeOrAfter "event3" model) ]
            ]


event4 : Model -> Html Msg
event4 model =
    wrap model InsertBeforeTarget "event4" <|
        div []
            [ span
                [ class "target"
                , class "button"
                , onClick (Event (beforeOrAfter "event4" model))
                ]
                []
            ]


event5 : Model -> Html Msg
event5 model =
    wrap model InsertBeforeTarget "event5" <|
        div []
            [ span
                [ class "target"
                , class "button"
                , Html.Attributes.map Event (onClick (beforeOrAfter "event5" model))
                ]
                []
            ]


event6 : Model -> Html Msg
event6 model =
    wrap model InsertBeforeTarget "event6" <|
        div []
            [ Html.map Event <|
                span
                    [ class "target"
                    , class "button"
                    , onClick (beforeOrAfter "event6" model)
                    ]
                    []
            ]


event7 : Model -> Html Msg
event7 model =
    wrap model InsertBeforeTarget "event7" <|
        div []
            [ span
                [ class "target"
                , class "button"
                , Html.Attributes.map (\s -> Event s) <|
                    onClick (beforeOrAfter "event7" model)
                ]
                []
            ]


event8 : Model -> Html Msg
event8 model =
    wrap model InsertBeforeTarget "event8" <|
        div []
            [ Html.map (\s -> Event s) <|
                span
                    [ class "target"
                    , class "button"
                    , onClick (beforeOrAfter "event8" model)
                    ]
                    []
            ]


event9 : Model -> Html Msg
event9 model =
    wrap model InsertBeforeTarget "event9" <|
        div [ class (beforeOrAfter "event9" model) ]
            [ span
                [ class "button"
                , class "prev"
                , onClick (Event "prev")
                ]
                []
            , span
                [ class "target"
                , class "button"
                , onClick (Event "target")
                ]
                []
            , span
                [ class "button"
                , class "next"
                , onClick (Event "next")
                ]
                []
            ]


event10 : Model -> Html Msg
event10 model =
    wrap model InsertBeforeTarget "event10" <|
        div []
            [ span
                [ class "button"
                , class "prev"
                , onClick (Event "prev")
                ]
                [ text (count "event10" model) ]
            , span
                [ class "target"
                , class "button"
                , onClick (Event "target")
                ]
                [ text (count "event10" model) ]
            , span
                [ class "button"
                , class "next"
                , onClick (Event "next")
                ]
                [ text (count "event10" model) ]
            ]


event11 : Model -> Html Msg
event11 model =
    wrap model InsertBeforeTarget "event11" <|
        Html.Keyed.node "div"
            [ class (beforeOrAfter "event11" model) ]
            [ ( "0"
              , span
                    [ class "button"
                    , class "prev"
                    , onClick (Event "prev")
                    ]
                    []
              )
            , ( "1"
              , span
                    [ class "target"
                    , class "button"
                    , onClick (Event "target")
                    ]
                    []
              )
            , ( "2"
              , span
                    [ class "button"
                    , class "next"
                    , onClick (Event "next")
                    ]
                    []
              )
            ]


event12 : Model -> Html Msg
event12 model =
    wrap model InsertBeforeTarget "event12" <|
        Html.Keyed.node "div"
            []
            [ ( "0"
              , span
                    [ class "button"
                    , class "prev"
                    , onClick (Event "prev")
                    ]
                    [ text (count "event12" model) ]
              )
            , ( "1"
              , span
                    [ class "target"
                    , class "button"
                    , onClick (Event "target")
                    ]
                    [ text (count "event12" model) ]
              )
            , ( "2"
              , span
                    [ class "button"
                    , class "next"
                    , onClick (Event "next")
                    ]
                    [ text (count "event12" model) ]
              )
            ]


event13 : Model -> Html Msg
event13 model =
    wrap model InsertBeforeTarget "event13" <|
        div [ class (beforeOrAfter "event13" model) ]
            [ lazy
                (\_ ->
                    span
                        [ class "button"
                        , class "prev"
                        , onClick (Event "prev")
                        ]
                        []
                )
                ()
            , lazy
                (\_ ->
                    span
                        [ class "target"
                        , class "button"
                        , onClick (Event "target")
                        ]
                        []
                )
                ()
            , lazy
                (\_ ->
                    span
                        [ class "button"
                        , class "next"
                        , onClick (Event "next")
                        ]
                        [ lazy viewText "" ]
                )
                ()
            ]


event14 : Model -> Html Msg
event14 model =
    wrap model InsertBeforeTarget "event14" <|
        div []
            [ span
                [ class "button"
                , class "prev"
                , onClick (Event "prev")
                ]
                [ lazy viewText (count "event14" model) ]
            , span
                [ class "target"
                , class "button"
                , onClick (Event "target")
                ]
                [ lazy viewText (count "event14" model) ]
            , span
                [ class "button"
                , class "next"
                , onClick (Event "next")
                ]
                [ lazy viewText (count "event14" model) ]
            ]


event15 : Model -> Html Msg
event15 model =
    wrap model WrapTarget "event15" <|
        div []
            [ span
                [ class "target"
                , class "button"
                , Html.Attributes.map Event <|
                    onClick (beforeOrAfter "event15" model)
                ]
                []
            ]


event16 : Model -> Html Msg
event16 model =
    wrap model WrapTarget "event16" <|
        div []
            [ Html.map Event <|
                span
                    [ class "target"
                    , class "button"
                    , onClick (beforeOrAfter "event16" model)
                    ]
                    []
            ]


event17 : Model -> Html Msg
event17 model =
    wrap model WrapTarget "event17" <|
        div []
            [ span
                [ class "target"
                , class "button"
                , Html.Attributes.map (\s -> Event s) <|
                    onClick (beforeOrAfter "event17" model)
                ]
                []
            ]


event18 : Model -> Html Msg
event18 model =
    wrap model WrapTarget "event18" <|
        div []
            [ Html.map (\s -> Event s) <|
                span
                    [ class "target"
                    , class "button"
                    , onClick (beforeOrAfter "event18" model)
                    ]
                    []
            ]



-- KEYED


keyed1 : Model -> Html Msg
keyed1 model =
    wrap model InsertBeforeTarget "keyed1" <|
        Html.Keyed.node "div"
            []
            [ ( "0"
              , div
                    [ class "target"
                    , class ("e" ++ count "keyed1" model)
                    ]
                    []
              )
            ]


keyed2 : Model -> Html Msg
keyed2 model =
    wrap model InsertBeforeTarget "keyed2" <|
        Html.Keyed.node "div"
            [ class ("e" ++ count "keyed2" model) ]
            [ ( count "keyed2" model
              , div
                    [ class "target"
                    ]
                    []
              )
            ]


keyed3 : Model -> Html Msg
keyed3 model =
    wrap model InsertBeforeTarget "keyed3" <|
        Html.Keyed.node "div"
            []
            [ ( count "keyed3" model
              , div
                    [ class "target"
                    , class ("e" ++ count "keyed3" model)
                    ]
                    [ text ("e" ++ count "keyed3" model) ]
              )
            ]


keyed4 : Model -> Html Msg
keyed4 model =
    wrap model InsertBeforeTarget "keyed4" <|
        div []
            [ Html.Keyed.node "div"
                [ class "target"
                , class ("e" ++ count "keyed4" model)
                ]
                []
            ]


keyed5 : Model -> Html Msg
keyed5 model =
    wrap model WrapTarget "keyed5" <|
        div []
            [ Html.Keyed.node "div"
                [ class "target"
                , class ("e" ++ count "keyed5" model)
                ]
                []
            ]


keyed6 : Model -> Html Msg
keyed6 model =
    wrap model UpdateAttribute "keyed6" <|
        Html.Keyed.node "div"
            []
            [ ( "1"
              , div
                    [ class "target"
                    , class ("e" ++ count "keyed6" model)
                    ]
                    [ text (count "keyed6" model) ]
              )
            ]


keyed7 : Model -> Html Msg
keyed7 model =
    wrap model UpdateAttribute "keyed7" <|
        Html.Keyed.node "div"
            [ class ("e" ++ count "keyed7" model) ]
            [ ( "1"
              , div
                    [ class "target"
                    ]
                    []
              )
            ]


keyed8 : Model -> Html Msg
keyed8 model =
    wrap model UpdateAttribute "keyed8" <|
        Html.Keyed.node "div"
            [ class ("e" ++ count "keyed8" model) ]
            [ ( count "keyed8" model
              , div
                    [ class "target"
                    ]
                    [ text (count "keyed8" model) ]
              )
            ]


keyed9 : Model -> Html Msg
keyed9 model =
    wrap model UpdateAttribute "keyed9" <|
        Html.Keyed.node "div"
            []
            (if beforeOrAfter "keyed9" model == "before" then
                [ ( "1"
                  , div
                        [ class "target"
                        ]
                        []
                  )
                ]

             else
                []
            )


keyed10 : Model -> Html Msg
keyed10 model =
    wrap model UpdateAttribute "keyed10" <|
        Html.Keyed.node "div"
            []
            (if beforeOrAfter "keyed10" model == "before" then
                [ ( "1"
                  , div
                        [ class "target"
                        , class "e1"
                        ]
                        []
                  )
                , ( "2"
                  , div
                        [ class "e2"
                        ]
                        []
                  )
                ]

             else
                [ ( "2"
                  , div
                        [ class "e2"
                        ]
                        []
                  )
                , ( "1"
                  , div
                        [ class "target"
                        , class "e1"
                        ]
                        []
                  )
                ]
            )


keyed11 : Model -> Html Msg
keyed11 model =
    wrap model UpdateAttribute "keyed11" <|
        Html.Keyed.node "div"
            []
            (if beforeOrAfter "keyed11" model == "before" then
                [ ( "1"
                  , div
                        [ class "e1"
                        ]
                        []
                  )
                , ( "2"
                  , div
                        [ class "target"
                        , class "e2"
                        ]
                        []
                  )
                ]

             else
                [ ( "2"
                  , div
                        [ class "target"
                        , class "e2"
                        ]
                        []
                  )
                , ( "1"
                  , div
                        [ class "e1"
                        ]
                        []
                  )
                ]
            )


keyed12 : Model -> Html Msg
keyed12 model =
    wrap model InsertBeforeTarget "keyed12" <|
        Html.Keyed.node "div"
            []
            (if beforeOrAfter "keyed12" model == "before" then
                [ ( "1"
                  , div
                        [ class "target"
                        , class "e1"
                        ]
                        []
                  )
                , ( "2"
                  , div
                        [ class "e2"
                        ]
                        []
                  )
                ]

             else
                [ ( "2"
                  , div
                        [ class "e2"
                        ]
                        []
                  )
                , ( "1"
                  , div
                        [ class "target"
                        , class "e1"
                        ]
                        []
                  )
                ]
            )


keyed13 : Model -> Html Msg
keyed13 model =
    wrap model InsertBeforeTarget "keyed13" <|
        Html.Keyed.node "div"
            []
            (if beforeOrAfter "keyed13" model == "before" then
                [ ( "1"
                  , div
                        [ class "e1"
                        ]
                        []
                  )
                , ( "2"
                  , div
                        [ class "target"
                        , class "e2"
                        ]
                        []
                  )
                ]

             else
                [ ( "2"
                  , div
                        [ class "target"
                        , class "e2"
                        ]
                        []
                  )
                , ( "1"
                  , div
                        [ class "e1"
                        ]
                        []
                  )
                ]
            )


keyed14 : Model -> Html Msg
keyed14 model =
    wrap model InsertBeforeTarget "keyed14" <|
        Html.Keyed.node "div"
            []
            (if beforeOrAfter "keyed14" model == "before" then
                [ ( "1"
                  , div
                        [ class "target"
                        , class "e1"
                        ]
                        []
                  )
                ]

             else
                [ ( "1"
                  , div
                        [ class "target"
                        , class "e1"
                        ]
                        []
                  )
                , ( "2"
                  , div
                        [ class "e2"
                        ]
                        []
                  )
                ]
            )


keyed15 : Model -> Html Msg
keyed15 model =
    wrap model InsertBeforeTarget "keyed15" <|
        Html.Keyed.node "div"
            []
            (if beforeOrAfter "keyed15" model == "before" then
                [ ( "1"
                  , div
                        [ class "target"
                        , class "e1"
                        ]
                        []
                  )
                ]

             else
                [ ( "2"
                  , div
                        [ class "e2"
                        ]
                        []
                  )
                , ( "1"
                  , div
                        [ class "target"
                        , class "e1"
                        ]
                        []
                  )
                ]
            )


keyed16 : Model -> Html Msg
keyed16 model =
    wrap model InsertBeforeTarget "keyed16" <|
        Html.Keyed.node "div"
            []
            (if beforeOrAfter "keyed16" model == "before" then
                [ ( "1"
                  , div
                        [ class "target"
                        ]
                        []
                  )
                ]

             else
                []
            )


keyed17 : Model -> Html Msg
keyed17 model =
    wrap model AppendToTarget "keyed17" <|
        Html.Keyed.node "div"
            [ class "target" ]
            [ ( "1", text (count "keyed17" model) ) ]


keyed18 : Model -> Html Msg
keyed18 model =
    wrap model AppendToTarget "keyed18" <|
        Html.Keyed.node "div"
            [ class "target" ]
            [ ( count "keyed18" model, text (count "keyed18" model) ) ]


keyed19 : Model -> Html Msg
keyed19 model =
    wrap model AppendToTarget "keyed19" <|
        Html.Keyed.node "div"
            [ class "target" ]
            (if beforeOrAfter "keyed19" model == "before" then
                [ ( "1", text "" ) ]

             else
                []
            )


keyed20 : Model -> Html Msg
keyed20 model =
    wrap model AppendToTarget "keyed20" <|
        Html.Keyed.node "div"
            [ class "target" ]
            (if beforeOrAfter "keyed20" model == "before" then
                []

             else
                [ ( "1", text "" ) ]
            )


keyed21 : Model -> Html Msg
keyed21 model =
    wrap model AppendToTarget "keyed21" <|
        Html.Keyed.node "div"
            [ class "target" ]
            [ ( "1", div [ class ("e" ++ count "keyed21" model) ] [ text (count "keyed21" model) ] ) ]


keyed22 : Model -> Html Msg
keyed22 model =
    wrap model AppendToTarget "keyed22" <|
        Html.Keyed.node "div"
            [ class "target" ]
            [ ( count "keyed22" model, div [ class ("e" ++ count "keyed22" model) ] [ text (count "keyed22" model) ] ) ]


keyed23 : Model -> Html Msg
keyed23 model =
    wrap model AppendToTarget "keyed23" <|
        Html.Keyed.node "div"
            [ class "target" ]
            (if beforeOrAfter "keyed23" model == "before" then
                [ ( "1", div [ class "e1" ] [ text "" ] ) ]

             else
                []
            )


keyed24 : Model -> Html Msg
keyed24 model =
    wrap model AppendToTarget "keyed24" <|
        Html.Keyed.node "div"
            [ class "target" ]
            (if beforeOrAfter "keyed24" model == "before" then
                []

             else
                [ ( "1", div [ class "e1" ] [ text "" ] ) ]
            )



-- LAZY


viewText1 : String -> Html msg
viewText1 s =
    text s


viewDiv1 : String -> Html msg
viewDiv1 s =
    div [] [ text s ]


viewTarget1 : String -> Html msg
viewTarget1 s =
    div [ class "target" ] [ text s ]


lazy1 : Model -> Html Msg
lazy1 model =
    wrap model InsertBeforeTarget "lazy1" <|
        div []
            [ div [ class "target" ] [ lazy viewText1 (beforeOrAfter "lazy1" model) ]
            ]


lazy2 : Model -> Html Msg
lazy2 model =
    wrap model RemoveTarget "lazy2" <|
        div []
            [ div [ class "target" ] [ lazy viewText1 (beforeOrAfter "lazy2" model) ]
            ]


lazy3 : Model -> Html Msg
lazy3 model =
    wrap model WrapTarget "lazy3" <|
        div []
            [ div [ class "target" ] [ lazy viewText1 (beforeOrAfter "lazy3" model) ]
            ]


lazy4 : Model -> Html Msg
lazy4 model =
    wrap model AppendToTarget "lazy4" <|
        div [ class "target" ]
            [ lazy viewText1 (beforeOrAfter "lazy4" model)
            ]


lazy5 : Model -> Html Msg
lazy5 model =
    wrap model InsertBeforeTarget "lazy5" <|
        div []
            [ div [ class "target" ] [ lazy viewDiv1 (beforeOrAfter "lazy5" model) ]
            ]


lazy6 : Model -> Html Msg
lazy6 model =
    wrap model RemoveTarget "lazy6" <|
        div []
            [ div [ class "target" ] [ lazy viewDiv1 (beforeOrAfter "lazy6" model) ]
            ]


lazy7 : Model -> Html Msg
lazy7 model =
    wrap model WrapTarget "lazy7" <|
        div []
            [ div [ class "target" ] [ lazy viewDiv1 (beforeOrAfter "lazy7" model) ]
            ]


lazy8 : Model -> Html Msg
lazy8 model =
    wrap model AppendToTarget "lazy8" <|
        div [ class "target" ]
            [ lazy viewDiv1 (beforeOrAfter "lazy8" model)
            ]


lazy9 : Model -> Html Msg
lazy9 model =
    wrap model InsertBeforeTarget "lazy9" <|
        div []
            [ div [ class "target" ] [ lazy text (beforeOrAfter "lazy9" model) ]
            ]


lazy10 : Model -> Html Msg
lazy10 model =
    wrap model RemoveTarget "lazy10" <|
        div []
            [ div [ class "target" ] [ lazy text (beforeOrAfter "lazy10" model) ]
            ]


lazy11 : Model -> Html Msg
lazy11 model =
    wrap model WrapTarget "lazy11" <|
        div []
            [ div [ class "target" ] [ lazy text (beforeOrAfter "lazy11" model) ]
            ]


lazy12 : Model -> Html Msg
lazy12 model =
    wrap model AppendToTarget "lazy12" <|
        div [ class "target" ]
            [ lazy text (beforeOrAfter "lazy12" model)
            ]


lazy13 : Model -> Html Msg
lazy13 model =
    wrap model InsertBeforeTarget "lazy13" <|
        div []
            [ div [ class "target" ] [ lazy (\s -> text s) (beforeOrAfter "lazy13" model) ]
            ]


lazy14 : Model -> Html Msg
lazy14 model =
    wrap model RemoveTarget "lazy14" <|
        div []
            [ div [ class "target" ] [ lazy (\s -> text s) (beforeOrAfter "lazy14" model) ]
            ]


lazy15 : Model -> Html Msg
lazy15 model =
    wrap model WrapTarget "lazy15" <|
        div []
            [ div [ class "target" ] [ lazy (\s -> text s) (beforeOrAfter "lazy15" model) ]
            ]


lazy16 : Model -> Html Msg
lazy16 model =
    wrap model AppendToTarget "lazy16" <|
        div [ class "target" ]
            [ lazy (\s -> text s) (beforeOrAfter "lazy16" model)
            ]


lazy17 : Model -> Html Msg
lazy17 model =
    wrap model InsertBeforeTarget "lazy17" <|
        div []
            [ lazy viewTarget1 (beforeOrAfter "lazy17" model)
            ]


lazy18 : Model -> Html Msg
lazy18 model =
    wrap model RemoveTarget "lazy18" <|
        div []
            [ lazy viewTarget1 (beforeOrAfter "lazy18" model)
            ]


lazy19 : Model -> Html Msg
lazy19 model =
    wrap model WrapTarget "lazy19" <|
        div []
            [ lazy viewTarget1 (beforeOrAfter "lazy19" model)
            ]


lazy20 : Model -> Html Msg
lazy20 model =
    wrap model AppendToTarget "lazy20" <|
        lazy viewTarget1 (beforeOrAfter "lazy20" model)
