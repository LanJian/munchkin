$(document).ready ->
  game = new Game()
  game.init()

class Game
  constructor: ->

  init: ->
    @socket = io.connect 'http://localhost:3000'
    @initCallbacks()
    @initListeners()

    setTimeout ( =>
      $('#game-nav').fadeOut()
    ), 2000

  initCallbacks: () ->
    @socket.on 'dirty', (toPoll) =>
      for event in toPoll
        @socket.emit event

    @socket.on 'updatePlayers', (data) =>
      console.log data
      $('#player-container').empty()
      for player in data.players
        item = $('#player-template').clone()
        item.removeClass 'hidden'
        item.removeAttr 'id'
        item.attr 'title', player.name
        item.tooltip()
        if data.me.id == player.id
          item.addClass 'player-me'
        $('#player-container').append(item)
      if data.leader.id == data.me.id
        $('a#start-game-btn').removeClass 'invisible'


  initListeners: ->
    $('a#start-game-btn').click =>
      @startGame()

    $('input#enter-name').blur =>
      @setName $('input#enter-name').val()
    $('input#enter-name').keypress (e) =>
      if e.which == 13
        $('input#enter-name').trigger 'blur'


  startGame: ->
    @socket.emit 'startGame'


  setName: (name) ->
    console.log $('.player-me')
    setTimeout ( ->
      $('.player-me').trigger 'mouseenter'
    ), 100
    setTimeout ( ->
      $('.player-me').trigger 'blur'
    ), 2100
    @socket.emit 'setName', {name: name}
