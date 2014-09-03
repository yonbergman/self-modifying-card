class App.Views.ChangeSideView extends App.Views.AbstractSelectionView

  changed: ->
    super
    @model.resetFactionKind()