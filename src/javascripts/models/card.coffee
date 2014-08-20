class App.Models.Card extends Backbone.Model
  defaults:
    side: 'corp'
    faction: 'neutral'
    kind: 'ice'

  @SIDES: ['corp', 'runner']
  @FACTIONS: {
   corp: ['neutral', 'weyland', 'haas', 'jinteki', 'nbn'],
   runner: ['neutral', 'anarch', 'criminal', 'shaper'],
  }

  @KINDS: {
    corp: ['identity', 'agenda', 'asset', 'operation', 'upgrade', 'ice'],
    runner: ['identity', 'event', 'hardware', 'program', 'resource'],
  }

  factionsForSide: ->
    App.Models.Card.FACTIONS[@get('side')]

  kindsForSide: ->
    App.Models.Card.KINDS[@get('side')]

  isRunner: ->
    @get('side') == 'runner'


  image: ->
    if @get('kind')
      "/img/#{@get('kind')}/#{@get('kind')}_#{@get('faction')}.jpg"
    else
      "/img/#{@get('side')}-back.jpg"