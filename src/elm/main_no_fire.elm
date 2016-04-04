
import Effects exposing (Effects, Never)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task
import Debug
import Window
import Signal exposing (message, mailbox, Mailbox)
import Types exposing (..)
import StartApp
import View exposing (paragraphs, headerImage, break, emailField)



init : (Model, Effects Action)
init = 
  ( Model "", Effects.none )


-- UPDATE


email : Mailbox String
email = mailbox ""


port submit : Signal String
port submit =
  email.signal


submission : String -> Effects Action
submission email' = 
  Signal.send email.address email' 
  |> Task.map (always (RefreshField "Thanks!")) 
  |> Effects.task


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of 

    RefreshField field ->
      (Model field, Effects.none)
    
    Subscribe ->
      (model, submission model.email)


-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  let 

    field = 
      emailField 
        model.email 
        address

    body =       
      headerImage 
      :: field
      :: break
      :: paragraphs

  in
    div 
      [ style 
          [ ("margin",  "auto")
          , ("width",   "60%")
          , ("padding", "10px")
          ]
      ]
      body


-- APP


app =
  StartApp.start
    { init   = init
    , update = update
    , view   = view
    , inputs = []
    }


main =
  app.html



-- PORTS


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks



