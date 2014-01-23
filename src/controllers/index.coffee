
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
      games[req.sessionID] = []
      res.redirect 303, "/#{req.sessionID}"
    else
      res.send "you are already in a game: #{gameId}"


  app.get '/:gameId', (req, res) ->
    gameId = req.params.gameId
    console.log games
    if !games[gameId]
      res.send 404, "game #{gameId} not found"
    else
      res.render 'game',
        gameId: gameId




    #io.sockets.once 'connection', (socket) ->
      #socket.join gameId
      #console.log io.sockets.manager.rooms
