class App.Controllers.CardBuilder
  constructor: ->
    @model = new App.Models.Card()
    window.model = @model
    @formView = new App.Views.FormView(model: @model)
    @cardView = new App.Views.CardView(model: @model)


$(document).on 'ready', ->
  App.controller = new App.Controllers.CardBuilder()