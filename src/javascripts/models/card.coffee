class App.Models.Card extends Backbone.Model
  defaults:
    side: 'corp'
    faction: 'neutral'
    kind: 'agenda'
    unique: false
    name: 'Sample Card'
    price: '3'
    strength: '2'
    type: 'strong - stealth'
    text: 'If Snare! is accessed from R&D, the Runner must reveal it.'
    fluff: 'It\'s bite is worse than it\'s bark'

  options:
    side: ['corp', 'runner']
    faction:
      corp: ['neutral', 'weyland', 'haas', 'jinteki', 'nbn'],
      runner: ['neutral', 'anarch', 'criminal', 'shaper'],
    kind:
      corp: ['agenda', 'asset', 'operation', 'upgrade', 'ice'],
      runner: ['event', 'hardware', 'program', 'resource'],

  @strengthMeaning:
    agenda: 'Agenda Points'
    asset: 'Trash Cost'
    upgrade: 'Trash Cost'
    ice: 'Strength'

  isRunner: ->
    @get('side') == 'runner'

  isUnique: ->
    !!@get('unique')

  image: ->
    if @get('kind')
      "/img/#{@get('kind')}/#{@get('kind')}_#{@get('faction')}.png"
    else
      "/img/#{@get('side')}-back.jpg"

