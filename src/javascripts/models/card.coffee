class App.Models.Card extends Backbone.Model
  defaults:
#    side: 'corp'
    side: 'runner'
    faction: 'neutral'
#    kind: 'agenda'
    kind: 'program'
    unique: false
    name: 'Sample Card'
    price: '3'
    strength: '2'
    influence: 2
    mu: 1
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
    program: 'Strength'

  initialize: ->
    @on('change:side', @resetFactionKind)

  resetFactionKind: ->
    if @isRunner()
      @set(kind: 'program', faction: 'shaper')
    else
      @set(kind: 'ice', faction: 'jinteki')

  isRunner: ->
    @get('side') == 'runner'

  isUnique: ->
    !!@get('unique')

  hasInfluence: ->
    @get('kind')!='agenda' or @get('faction') == 'neutral'

  image: ->
    if @get('kind')
      "/img/#{@get('kind')}/#{@get('kind')}_#{@get('faction')}.png"
    else
      "/img/#{@get('side')}-back.jpg"

