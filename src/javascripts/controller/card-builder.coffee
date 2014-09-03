class App.Controllers.CardBuilder
  constructor: ->
    @model = new App.Models.Card()
    window.model = @model
    @formView = new App.Views.FormView(model: @model)
    @cardView = new App.Views.CardView(model: @model)
    @saveImageView = new App.Views.SaveImageView(model: @model)
    unless navigator.userAgent.toLowerCase().indexOf('chrome') > -1
      $('.browser-alert').removeClass('hidden')


$(document).on 'ready', ->
  App.controller = new App.Controllers.CardBuilder()