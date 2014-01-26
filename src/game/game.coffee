Player = require './player'

module.exports = class Game

  constructor: (@id, @io) ->
    console.log 'new game'
    @players = {}

  addPlayer: (socket) ->
    player = new Player socket
    @players[socket.id] = player
    socket.join @id
    @initCallbacks socket
    if Object.keys(@players).length == 1
      @setLeader player
    @io.sockets.in(@id).emit 'dirty', ['getPlayers']

  removePlayer: (socket) ->
    delete @players[socket.id]
    socket.leave @id
    @io.sockets.in(@id).emit 'dirty', ['getPlayers']

  setLeader: (player) ->
    @leader = player
    player.isLeader = true

  initCallbacks: (socket) ->
    socket.on 'getPlayers', =>
      data = {players: []}
      for id, player of @players
        data.players.push player.getData()
        if id == socket.id
          data.me = player.getData()
      data.leader = @leader.getData()
      socket.emit 'updatePlayers', data
