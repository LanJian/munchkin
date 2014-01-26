Game = require '../game/game'

module.exports = (app) ->

  io = app.io

  # TODO: this is shitty poorman's database,
  # move this to redis or something.
  games = {}

  app.get '/', (req, res) ->
    res.render 'index'


  app.get '/new', (req, res) ->
    # TODO: search through players, anyone already in game should not be
    # able to create another one
    gameId = req.sessionID
    if !games[gameId]
      games[gameId] = new Game gameId, io
      res.redirect 303, "/#{req.sessionID}"
    else
      res.send "you are already in a game: #{gameId}"


  app.get '/:gameId', (req, res) ->
    gameId = req.params.gameId
    game = games[gameId]
    if !game
      res.send 404, "game #{gameId} not found"
    else
      io.sockets.once 'connection', (socket) ->
        game.addPlayer socket
        socket.on 'disconnect', ->
          game.removePlayer socket
      res.render 'game',
        gameId: gameId




    #io.sockets.once 'connection', (socket) ->
      #socket.join gameId
      #console.log io.sockets.manager.rooms
