--import Effects exposing (Effects, Never)
module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (message)
import Types exposing (..)
import Json.Decode as Json


paragraphs : List Html
paragraphs = 
  [ p 
      [ class "point" ] 
      [ text "CtPaint is a simple image editor that runs in your browser. Its simple. Its fast. Its the ideal for making pixel art, and drawing memes. Its also closely integrated with social media platforms like facebook and twitter. As easily as you can google search an image, you can open it up, edit it, and save it, in CtPaint." ]
  , break
  , p 
      [ class "point" ] 
      [ text "An alpha version of CtPaint already exists for free. Id like to make it into something much greater than what it is today. Enter your email in the field above to stay in the loop." ]
  ]


headerImage : Html
headerImage = 
  img 
    [ style 
        [ ("margin",  "auto")
        , ("display", "block")
        ]
    , src "ctpaint-logo.png" 
    ] 
    []


break : Html
break = 
  br [] []


goToApp : Html
goToApp = 
  div 
    [ style 
        [ ("margin",     "auto")
        , ("width",      "80%" ) 
        , ("margin-top", "1em" )
        ]
    ] 
    [ p
        [ class "point" 
        , style
            [ ("width",        "44px"  )
            , ("margin",       "0px"   ) 
            , ("display",      "inline")
            , ("font-size",    "4em"   )
            , ("margin-right", "22px"  ) 
            ]
        ]
        [ text "or" ]

    , a
        [ style 
            [ ("background-color", "#030907")
            , ("border",           "none"   )
            , ("outline",          "none"   )
            , ("font-size",        "4em"    )
            , ("display",          "inline" )
            ]
        , class  "point link"
        , href "http://chadtech.github.io/ctpt/ctpaint.html#no-back-button"
        ] 
        [ text   "go to CtPaint"  ]
  ]


emailField : String -> Signal.Address Action -> Html
emailField content address =
  div 
    [ style 
        [ ("margin",  "auto")
        , ("width",   "60%")
        ]
    ] 
    [ input 
        [ class       "field"
        , placeholder "enter your email here"
        , value       content
        , on "input"  targetValue 
          <| \str -> message address 
          <| RefreshField str
        ] 
        []
    
    , button 
        [ style 
            [ ("background-color", "#030907")
            , ("border",           "none"   )
            , ("outline",          "none"   )
            ]
        , class  "point link"
        , onClick address Subscribe
        ] 
        [ text   "subscribe"  ]
    
    , div 
      [ style 
          [ ("margin", "auto")
          , ("width",  "100%")
          ]
      ]
      [  p 
        [ class "point ignorable" ]
        [ text "I wont email you much, nor give your email away"] 
      ]

    , goToApp

    ]


