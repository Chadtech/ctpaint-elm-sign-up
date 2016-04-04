This is a simple landing page I made, that includes an email subscription field that can add an email to a firebase database.

Its also made in elm, so if you want to see a simple Elm application that uses firebase, you can look at this one.

There are two main elm files, one is 'main.elm', the other is 'main_no_fire.elm', which doesnt use the Elm firebase package 'elm-fire'. Instead, main_no_elm uses a port to javascript which reaches the firebase server.