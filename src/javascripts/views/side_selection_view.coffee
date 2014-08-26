class App.Views.SideSelectionView extends App.Views.SelectionView

  initialize: (@options)->
    super
    @model.on('change:side', @updateSelections)

  updateSelections: =>
    super
    @options.selections = @options.selections[@model.get('side')]