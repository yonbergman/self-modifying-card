class App.Views.FormView extends Backbone.View
  el: '.form-view'

  initialize: ->
    @sections = [
      new App.Views.SelectionView(model: @model, attribute: 'side')
      new App.Views.SideSelectionView(model: @model, attribute: 'faction')
      new App.Views.SideSelectionView(model: @model, attribute: 'kind')
#      new App.Views.SimpleAttributeView(model: @model, attribute: 'name')
#      new App.Views.NumberAttributeView(model: @model, attribute: 'price')
#      new App.Views.SimpleAttributeView(model: @model, attribute: 'type')
      new App.Views.AttributesView(model: @model)
      ]
    @render()

  render: =>
    @$el.find('form').empty()
    for section in @sections
      @$el.find('form').append(section.render().el)