class App.Models.Card extends Backbone.Model
  defaults:
    side: 'corp'
    faction: 'neutral'

  @SIDES: ['corp', 'runner']
  @FACTIONS: {
   corp: ['neutral', 'weyland', 'haas-bioroid', 'jinteki', 'nbn'],
   runner: ['neutral', 'anarch', 'criminal', 'shaper'],
  }

  @KINDS: {
    corp: ['identity', 'agenda', 'asset', 'operation', 'upgrade', 'ice'],
    runner: ['identity', 'event', 'hardware', 'program', 'resource'],
  }

  factionsForSide: ->
    App.Models.Card.FACTIONS[@get('side')]

  isRunner: ->
    @get('side') == 'runner'


  image: ->
    if @get('side') == 'runner'
      '/img/runner-back.jpg'
    else
      '/img/corp-back.jpg'
