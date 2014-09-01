class App.Models.Card extends Backbone.Model
  defaults:
    side: 'corp'
    side: 'corp'
    faction: 'jinteki'
    kind: 'asset'
    unique: false
    name: 'Mokujin'
    price: '0'
    strength: '2'
    influence: 2
    mu: 1
    type: 'ambush'
    text: "If you pay 2 [c] when the Runner accesses Mokujin,the runner must take Mokujin.\nWhile the runner has Mokujin he can't run on central servers.\n[click] [click] [click]: Trash Mokujin"
    fluff: '"I was completely stumped" - Whizzard'

    y: 272
    scale: 2.5
    img: "https://scontent-b-lhr.xx.fbcdn.net/hphotos-xpf1/v/t1.0-9/p235x350/10516676_10152217464281010_8925684994098200246_n.jpg?oh=8d345c197e82f74a375b5c79ac04461a&oe=545D9E1D"

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
    @set(kind: '', faction: '')

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

