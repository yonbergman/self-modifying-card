class App.Views.SideSelectionView extends App.Views.SelectionView

  initialize: (@options)->
    super
    @model.on('change:side', @refresh)

  refresh: =>
    @updateSelections()
    @render()

  updateSelections: =>
    super
    @options.selections = @options.selections[@model.get('side')]