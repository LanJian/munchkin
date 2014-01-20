
module.exports = (app) ->

  io = app.io

  app.all '/', (req, res) ->
    io.sockets.once 'connection', (socket) ->
      console.log 'joined', socket.id

      socket.on 'disconnect', ->
        console.log 'left', socket.id
    res.render 'index'
