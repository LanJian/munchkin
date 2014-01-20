$(document).ready ->
  init()

init = ->
  console.log 'lets go!'
  socket = io.connect 'http://localhost:3000'
