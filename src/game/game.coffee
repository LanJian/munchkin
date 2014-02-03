Player = require './player'
Card = require './card'
DoorCard = require './doorCard'
TreasureCard = require './treasureCard'
doorCards = require './doorCards'
treasureCards = require './treasureCards'

module.exports = class Game

  constructor: (@id, @io) ->
    console.log 'new game'
    @players = {}
    @leader = null
    @doorPile = doorCards
    @treasurePile = treasureCards
    @doorDiscardPile = []
    @treasureDiscardPile = []
    @currentPhase = null
    @currentPlayer = null

###############################################################################
# Socket Methods
###############################################################################

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


###############################################################################
# Game Logic Methods
###############################################################################

  discard: (card) ->
    if card.constructor is DoorCard
      @doorDiscardPile.push card
    else
      @treasureDiscardPile.push card

  shuffle: ->

  haveWinnner: ->
    for player in @players
      return true if player.level == 10
    return false

  determineFirstPlayer: ->
    playerKeys = Object.keys(@players)
    return playerKeys[Math.floor(Math.random() * playerKeys.length)]

  setup: ->
    shuffle @doorPile
    shuffle @treasurePile

    for player in @players
      player.draw @doorPile 4
      player.draw @treasurePile 4

    @currentPlayer = determineFirstPlayer()
