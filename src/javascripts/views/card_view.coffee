class App.Views.CardView extends Backbone.View
  className: 'card'
  el: '.card'

  events:
    'mousedown': 'start'
    'mousemove': 'move'
    'mouseup':   'stop'
    'mousewheel': 'scale'

  initialize: ->
    @model.on('change', @render)
    @model.set
      x: 0
      y: 0
      scale: 1
    @render()

  render: =>
    @$el.removeClass()
    @$el.addClass(@className)
    @$el.addClass(@model.get('kind'))
    imgView = @$el.find('img')
    imgView.attr('src', @model.image())
    if @model.get('img')
      imgView.css('background-image': "url(#{@model.get('img')})")
    imgView.css('background-position': "#{@model.get('x')}px #{@model.get('y')}px")
    imgView.css('background-size': "#{@model.get('scale')*100}%")
    for attr in ['name', 'price', 'strength', 'type', 'text', 'fluff']
      @$el.find(".#{attr}").text(@model.get(attr))

  ## MOVING 
  start: (ev) =>
    ev.preventDefault()
    @drag = true
    @saveLast(ev)

  stop: (ev)=>
    ev.preventDefault()
    @drag = false

  move: (ev) =>
    return unless @drag
    @model.set
      x: @model.get('x') + (ev.clientX - @lastX)
      y: @model.get('y') + (ev.clientY - @lastY)
    @saveLast(ev)


  saveLast: (ev) =>
    window.blah = ev
    @lastX = ev.clientX
    @lastY = ev.clientY

  ## SCALING
  scale: (ev) =>
    ev.preventDefault()
    scale = if ev.originalEvent.wheelDelta > 0 then 1.2 else (1/1.2)
    @model.set
      scale: @model.get('scale') * scale
