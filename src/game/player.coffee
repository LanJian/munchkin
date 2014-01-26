Moniker = require 'moniker'

module.exports = class Player

  constructor: (@socket) ->
    @id = @socket.id
    @name = Moniker.choose()
    @isLeader = false

  getData: ->
    {id: @id, name: @name, isLeader: @isLeader}
