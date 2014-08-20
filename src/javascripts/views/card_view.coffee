class App.Views.CardView extends View
  initialize: (params) ->
    @model = params.model
    @model.on('change', @reRender)

  @content: (params) ->
    @div =>
      @h2 "Card Preview"
      @div class: "card #{params.model.get('kind')}", =>
        @img src: params.model.image()
        @div class: 'name', 'Name'
        @div class: 'price', '3'
        @div class: 'strength', '2'
        @div class: 'type', 'strong'
        @div class: 'main-content', =>
          @div class: 'text', 'Does cool things'
          @div class: 'fluff', 'becuase we can'

  changeSide: (ev, el) ->
    @model.set(side: el.text(), faction: 'neutral')

  changeFaction: (ev, el) ->
    @model.set(faction: el.text())

  reRender: =>
    @replaceWith new App.Views.CardView(model: @model)