Moniker = require 'moniker'
Util = require '../util'

module.exports = class Player

  constructor: (@socket) ->
    @id = @socket.id
    names = Moniker.generator([Moniker.adjective, Moniker.noun], {glue: ' '})
    @name = Util.capitalize names.choose()
    @isLeader = false

  getData: ->
    {id: @id, name: @name, isLeader: @isLeader}
