class App.Views.FormView extends Backbone.View
  el: '.form-view'

  initialize: ->
    @sections = [
      new App.Views.SelectionView(model: @model, attribute: 'side')
      new App.Views.SideSelectionView(model: @model, attribute: 'faction')
      new App.Views.SideSelectionView(model: @model, attribute: 'kind')
      new App.Views.AttributesView(model: @model)
      ]
    @render()

  render: =>
    @$el.find('.section').remove()
    for section in @sections
      @$el.append(section.render().el)