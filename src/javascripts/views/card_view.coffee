class App.Views.CardView extends View
  initialize: (params) ->
    @model = params.model
    @model.on('change', @reRender)

  @content: (params) ->
    @div =>
      @h2 "Card Preview"
      @img src: params.model.image()

  changeSide: (ev, el) ->
    @model.set(side: el.text(), faction: 'neutral')

  changeFaction: (ev, el) ->
    @model.set(faction: el.text())

  reRender: =>
    @replaceWith new App.Views.CardView(model: @model)