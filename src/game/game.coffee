Player = require './player'

module.exports = class Game

  constructor: (@id, @io) ->
    console.log 'new game'
    @players = {}

  addPlayer: (socket) ->
    @players[socket.id] = new Player socket
    socket.join @id
    @initCallbacks socket
    console.log @players
    @io.sockets.in(@id).emit 'dirty', ['getPlayers']

  removePlayer: (socket) ->
    delete @players[socket.id]
    socket.leave @id
    @io.sockets.in(@id).emit 'dirty', ['getPlayers']

  initCallbacks: (socket) ->
    socket.on 'getPlayers', =>
      console.log @players
      data = []
      for k, v of @players
        data.push {id: k, name: v.name}
      socket.emit 'updatePlayers', data
