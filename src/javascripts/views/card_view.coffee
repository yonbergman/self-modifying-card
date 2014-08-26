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
    imgView = @$el.find('img')
    imgView.attr('src', @model.image())
    if @model.get('img')
      imgView.css('background-image': "url(#{@model.get('img')})")
    for attr in ['name', 'price', 'strength', 'type', 'text', 'fluff']
      @$el.find(".#{attr}").text(@model.get(attr))