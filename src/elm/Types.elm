module Types where

type Action
  = RefreshField String
  | Subscribe

type alias Model =
  { email:String, sent:Bool}
