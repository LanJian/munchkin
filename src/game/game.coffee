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
    # set leader to next player
    for id, player of @players
      @setLeader player
      break
    @io.sockets.in(@id).emit 'dirty', ['getPlayers']

  setLeader: (player) ->
    @leader = player
    player.isLeader = true

  getPlayers: (socket) ->
    data = {players: []}
    for id, player of @players
      data.players.push player.getData()
      if id == socket.id
        data.me = player.getData()
    data.leader = @leader.getData()
    return data

  initCallbacks: (socket) ->
    # State getters
    socket.on 'getPlayers', =>
      socket.emit 'updatePlayers', @getPlayers socket

    # State modifiers/setters
    socket.on 'setName', (data) =>
      name = data.name
      player = @players[socket.id]
      player.name = name
      @io.sockets.in(@id).emit 'dirty', ['getPlayers']
