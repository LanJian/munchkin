Moniker = require 'moniker'

module.exports = class Player

  constructor: (@socket) ->
    @id = @socket.id
    @name = Moniker.choose()
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
