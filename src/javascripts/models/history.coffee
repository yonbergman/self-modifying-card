class App.Models.History extends Backbone.Collection
  model: App.Models.Card
  localStorage: new Backbone.LocalStorage("history")

