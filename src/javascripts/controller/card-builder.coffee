class App.Controllers.CardBuilder
  constructor: ->
    @model = new App.Models.Card()
    @history = new App.Models.History()
    window.model = @model
    @model.collection = @history
    @history.fetch
      success: =>
        lastModel = @history.last()
        console.log(@history.length, lastModel.attributes)
        if lastModel
          @model.set(lastModel.attributes)
    @formView = new App.Views.FormView(model: @model)
    @cardView = new App.Views.CardView(model: @model)
    @saveImageView = new App.Views.SaveImageView(model: @model)
    unless navigator.userAgent.toLowerCase().indexOf('chrome') > -1
      $('.browser-alert').removeClass('hidden')


$(document).on 'ready', ->
  App.controller = new App.Controllers.CardBuilder()