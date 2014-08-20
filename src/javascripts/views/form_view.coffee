class App.Views.FormView extends View
  initialize: (params) ->
    @model = params.model
    @model.on('change', @reRender)

  @content: (params) ->
    @div =>
      @h2 "Customize your card"
      @div class: 'side', =>
        @small "Side:"
        @ul class: 'nav nav-pills nav-justified', =>
          _.each App.Models.Card.SIDES, (side) =>
            @li class: (if side == params.model.get('side') then "active" else ""), click: 'changeSide', =>
              @a side

      @div class: 'faction', =>
        @small "Faction:"
        @ul class: 'nav nav-pills nav-justified', =>
          _.each params.model.factionsForSide(), (faction) =>
            @li class: (if faction == params.model.get('faction') then "active" else ""), click: 'changeFaction', =>
              @a faction

  changeSide: (ev, el) ->
    @model.set(side: el.text(), faction: 'neutral')

  changeFaction: (ev, el) ->
    @model.set(faction: el.text())

  reRender: =>
    @replaceWith new App.Views.FormView(model: @model)