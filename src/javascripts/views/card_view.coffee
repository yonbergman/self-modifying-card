class App.Views.CardView extends Backbone.View
  className: 'card'
  el: '.card'

  initialize: ->
    @model.on('change', @render)
    @render()

  render: =>
    @$el.removeClass()
    @$el.addClass(@className)
    @$el.addClass(@model.get('kind'))
    @$el.find('img').attr('src', @model.image())
    for attr in ['name', 'price', 'strength', 'type', 'text', 'fluff']
      @$el.find(".#{attr}").text(@model.get(attr))