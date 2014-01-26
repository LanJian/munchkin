Player = require './player'

module.exports = class Game

  constructor: (@id, @io) ->
    console.log 'new game'
    @players = {}

  addPlayer: (socket) ->
    console.log "add player #{socket.id}"
    @players[socket.id] = new Player socket
    socket.join @id
    console.log @io.sockets.manager.rooms

  removePlayer: (socket) ->
    delete @players[socket.id]
    socket.leave @id
