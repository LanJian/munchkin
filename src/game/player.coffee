module.exports = class Player

  constructor: (@socket) ->
    @id = @socket.id
    @name = 'dummy'
