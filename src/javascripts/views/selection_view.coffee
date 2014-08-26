class App.Views.SelectionView extends Backbone.View
  className: 'selection'
  template: _.template("<label><%= attribute %>:</label><ul class='nav nav-pills nav-justified'></ul>")
  singleTemplate: _.template("<li><a href='javascript:;'><%= text %></a></li>")

  events:
    "click li": "clicked"

  initialize: (@options)->
    @updateSelections()
    model.on("change:#{@options.attribute}", @render)

  updateSelections: ->
    @options.selections = @model.options[@options.attribute]

  render: =>
    @$el.html(@template(@options))
    for selection in @options.selections
      el = $(@singleTemplate(text: selection))
      el.data(value: selection)
      el.addClass('active') if @model.get(@options.attribute) == selection
      @$el.find('ul').append(el)
    @

  clicked: (ev)->
    selection = $(ev.target).closest('li').data('value')
    @model.set(@options.attribute, selection)

