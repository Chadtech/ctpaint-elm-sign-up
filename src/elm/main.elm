import Effects exposing (Effects, Never)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task
import Debug
import Window
import Regex exposing (regex, escape, HowMany(..))
import Signal exposing (message, mailbox, Mailbox)
import Types exposing (..)
import StartApp
import Json.Encode as JE exposing (string, encode)
import View exposing (paragraphs, headerImage, break, emailField)
import ElmFire exposing
  ( fromUrl, set, push, subscribe, valueChanged, noOrder, noLimit
  , Reference, Snapshot, Subscription, Error
  )


init : (Model, Effects Action)
init = 
  ( Model "" False, Effects.none )

-- UTIL

url : String
-- Sorry, I dont want to share my firebase URL
-- Im worried about someone abusing my firebase
-- Its happened before :x
url = "Actual Firebase website goes here"

replace : String -> String -> String -> String
replace search substitution string =
  string
    |> Regex.replace All (regex (escape search)) (\_ -> substitution)

-- UPDATE

email : Mailbox String
email = mailbox "ye"


doNothing : a -> Task.Task x ()
doNothing = always (Task.succeed ())


urler : String -> String
urler str =
  replace "." "+dot+"
  <| replace "@" "+at+" str 


port submit : Signal (Task.Task Error Reference)
port submit =
  let 
    setter str =
      fromUrl <| url ++ (urler str)
  in
    Signal.map
      (\str -> set (string str) (setter str))
      email.signal


submission : Model -> Effects Action
submission m =
  if not m.sent then
    Signal.send email.address m.email
    |> Task.map (always (RefreshField "Thanks!")) 
    |> Effects.task
  else
    Effects.none


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of 

    RefreshField field ->
      (Model field model.sent, Effects.none)
    
    Subscribe ->
      (Model model.email True, submission model)

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



