class App.Views.CardView extends Backbone.View
  className: 'card'
  el: '.card'

  icons:
    credit: ['[credit]', '[cr]', '[c]']
    click: ['[click]']
    link: ['[link]']
    trash: ['[trash]']
    mu: ['[mu]']
    '1mu': ['[1mu]']
    '2mu': ['[2mu]']
    subroutine: ['[subroutine]', '[sub]','--->','-->','->']
    'recurring-credit': ['[recurring]']

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

    @$el.find('.name').text('◆ ' + @model.get('name')) if @model.isUnique()
    content = @$el.find(".text").text()
    @$el.find(".text").html(@iconify(content))
    @$el.find('.influence').removeClass().addClass('influence').addClass("i#{@model.get('influence')}")

  iconify: (content) =>
    for className, finders of @icons
      for finder in finders
        content = content.replace(@reg(finder), "<i class='icon icon-#{className}'></i>")
    content

  reg: (string) ->
    new RegExp(string.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1"), 'g')

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
    newScale = @model.get('scale') * scale
    newScale = Math.max(Math.min(newScale, 3), 0.25)
    @model.set
      scale: newScale
