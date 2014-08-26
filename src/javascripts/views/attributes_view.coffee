class App.Views.AttributesView extends Backbone.View
  className: 'attributes'
  template: _.template("""
<form class="form-horizontal" role="form">
  <br/>
  <div class="form-group">
    <label for="name" class="col-sm-3 control-label">Name:</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name" placeholder="Name">
    </div>
  </div>
  <div class="form-group">
    <label for="type" class="col-sm-3 control-label">Types:</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="type" placeholder="Type">
    </div>
  </div>
  <div class="form-group">
    <label for="price" class="col-sm-3 control-label">Cost:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="price" placeholder="Cost">
    </div>
  </div>
  <div class="form-group strength">
    <label for="strength" class="col-sm-3 control-label"><%= App.Models.Card.strengthMeaning[kind]%>:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="strength" placeholder="Strength">
    </div>
  </div>
  <div class="form-group">
    <label for="text" class="col-sm-3 control-label">Text:</label>
    <div class="col-sm-9">
      <textarea id="text" class="form-control"/>
    </div>
  </div>
  <div class="form-group">
    <label for="fluff" class="col-sm-3 control-label">Flavor:</label>
    <div class="col-sm-9">
      <textarea id="fluff" class="form-control"/>
    </div>
  </div>
</form>
""")

  initialize: (@options)->
    @model.on('change:kind', @render)

  events:
    'keyup input': 'updateContent'
    'keyup textarea': 'updateContent'

  render: =>
    @$el.html(@template(@model.attributes))
    @$el.find("input, textarea").each (idx, el) =>
      $(el).val(@model.get(el.id))
    @

  updateContent: (ev) =>
    el = $(ev.target)
    @model.set(el.get(0).id, el.val())