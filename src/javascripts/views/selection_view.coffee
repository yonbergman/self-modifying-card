class App.Views.SelectionView extends Backbone.View
  className: 'selection'
  template: _.template("""
<div class="form-group">
<label for="<%= attribute %>" class="col-sm-3 control-label"><%= attribute %>:</label>
  <div class="col-sm-9">
    <select class="form-control" id="<%= attribute %>"></select>
  </div>
</div>
""")
  singleTemplate: _.template("""
<option><%= text %></option>
""")

  events:
    "change select": "changed"

  initialize: (@options)->
    @updateSelections()
    model.on("change:#{@options.attribute}", @render)

  updateSelections: ->
    @options.selections = @model.options[@options.attribute]

  render: =>
    @$el.html(@template(@options))
    for selection in @options.selections
      el = $(@singleTemplate(text: selection))
      el.data(value: selection)
      el.attr('selected', true) if @model.get(@options.attribute) == selection
      @$el.find('select').append(el)
    @

  changed: (ev)->
    @model.set(@options.attribute, @$el.find('select').val())