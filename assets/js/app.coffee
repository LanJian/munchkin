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

  socket.on 'updatePlayers', (data) ->
    console.log data
    $('p#num-players').text "Number of players: #{data.players.length}"
    console.log data.leader.id, data.me.id
    if data.leader.id == data.me.id
      console.log 'yoyoo'
      console.log $('a#start-game-btn')
      $('a#start-game-btn').removeClass 'invisible'


initListeners = ->
  $('a#start-game-btn').click ->
    startGame()

startGame = ->
  socket.emit 'startGame'
