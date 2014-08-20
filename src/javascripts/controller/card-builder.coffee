class App.Controllers.CardBuilder
  constructor: ->
    @model = new App.Models.Card()
    @formView = new App.Views.FormView(model: @model)
    @cardView = new App.Views.CardView(model: @model)
    $('.form-view').append(@formView)
    $('.target-view').append(@cardView)


$(document).on 'ready', ->
  App.controller = new App.Controllers.CardBuilder()