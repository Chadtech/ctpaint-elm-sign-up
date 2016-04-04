# _        = require 'lodash'
# Firebase = require 'firebase'

main     = document.getElementById 'main'
app      = Elm.embed Elm.Main, main
# {submit} = app.ports
# URL      = 'https://ctpaint-pre-order.firebaseio.com/emails'

# submit.subscribe (email) ->
#   # payload  = {}

#   email = email.split ''
#   email = _.map email, (ch, i) ->
#     if ch is '@'
#       ch = ' +at+ '
#     if ch is '.'
#       ch = ' +dot+ '
#     ch

#   email = _.reduce email,
#     (sum, ch) ->
#       sum + ch
#     ''

#   key = _.reduce email,
#     (sum, ch) ->
#       _ch = ch.charCodeAt 0
#       sum + _ch.toString 36
#     ''

#   fb = new Firebase URL + '/' + key
#   fb.set email


  # console.log 'Submit Email!', what
  # backEnd email: email

# updateEmail.subscribe (what) ->
#   console.log 'Update Email!', what
#   email = what
