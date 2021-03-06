module App.View exposing (view)

import AmiibosTable.View
import App.Types exposing (..)
import Html
import Html.Attributes
import Material.Spinner
import Material.Layout
import RemoteData


view : Model -> Html.Html Msg
view model =
    case model.amiibos of
        RemoteData.Loading ->
            viewLayout model viewLoading

        RemoteData.Success amiibos ->
            viewLayout model (AmiibosTable.View.view AmiibosTableMsg amiibos model.amiibosTable)

        _ ->
            viewLayout model (AmiibosTable.View.view AmiibosTableMsg [] model.amiibosTable)


viewLayout : Model -> Html.Html Msg -> Html.Html Msg
viewLayout model mainView =
    Material.Layout.render Mdl
        model.mdl
        [ Material.Layout.fixedHeader
        ]
        { header = [ Html.h4 [ Html.Attributes.style [ ( "padding-left", "16px" ) ] ] [ Html.text "Amiibos" ] ]
        , drawer = []
        , tabs = ( [], [] )
        , main = [ mainView ]
        }


viewLoading : Html.Html m
viewLoading =
    Html.div
        [ (Html.Attributes.style
            [ ( "text-align", "center" )
            , ( "padding-top", "2em" )
            ]
          )
        ]
        [ Material.Spinner.spinner [ Material.Spinner.active True ] ]
