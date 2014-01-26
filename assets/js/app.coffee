$(document).ready ->
  init()

init = ->
  console.log 'lets go!'
  socket = io.connect 'http://localhost:3000'
  initCallbacks socket
  initListeners()

initCallbacks = (socket) ->
  socket.on 'dirty', (toPoll) ->
    console.log toPoll
    for event in toPoll
      socket.emit event

  socket.on 'updatePlayers', (players) ->
    console.log players
    $('p#num-players').text "Number of players: #{players.length}"


initListeners = ->
  $('btn#start-game-btn').click ->
    startGame()

startGame = ->
  socket.emit 'startGame'
