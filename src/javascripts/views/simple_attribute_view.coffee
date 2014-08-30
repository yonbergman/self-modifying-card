class App.Views.SimpleAttributeView extends Backbone.View
  template: _.template """
<div class="form-group">
  <label for="<%= attribute %>" class="col-sm-3 control-label"><%= attribute %>:</label>
  <div class="col-sm-5">
    <input type="text" class="form-control" id="<%= attribute %>" placeholder="<%= attribute %>">
  </div>
</div>
"""

  initialize: (@options)->

  events:
    'keyup input': 'updateContent'
    'change input': 'updateContent'
    'change textare': 'updateContent'
    'keyup textarea': 'updateContent'

  render: =>
    @$el.html(@template(@options))
    @$el.find("input, textarea").each (idx, el) =>
      $(el).val(@model.get(el.id))
    @

  updateContent: (ev) =>
    el = $(ev.target)
    val = el.val()
    @model.set(@options.attribute, val)