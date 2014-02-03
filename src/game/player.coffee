Moniker = require 'moniker'
Util = require '../util'

module.exports = class Player

  constructor: (@socket) ->
    @id = @socket.id
    names = Moniker.generator([Moniker.adjective, Moniker.noun], {glue: ' '})
    @name = Util.capitalize names.choose()
    @isLeader = false
    @level = 1
    @race = 'human'
    @munchkinClass = 'none'
    @handCards = []
    @equip = []
    @carried = []

  getData: ->
    {id: @id, name: @name, isLeader: @isLeader}

  draw: (pile, count) ->
    for i in [1..count]
      player.handCards.push(pile.pop())
