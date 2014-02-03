require 'player'

module.exports = [
  {
    newname: 'Dwarf'
    play: (player) ->
      player.race = 'Dwarf'
  },
  {
    name: 'Elf'
    play: (player) ->
      player.race = 'Elf'
  },
  {
    name: 'Halfling'
    play: (player) ->
      player.race = 'Halfling'
  },
  {
    name: 'Cleric'
    play: (player) ->
      player.munchkinClass = 'Cleric'
  },
  {
    name: 'Thief'
    play: (player) ->
      player.munchkinClass = 'Thief'
  },
  {
    name: 'Warrior'
    play: (player) ->
      player.munchkinClass = 'Warrior'
  },
  {
    name: 'Wizard'
    play: (player) ->
      player.munchkinClass = 'Wizard'
  },
  {
    name: 'Divine Intervention'
    play: () ->
  }
]
