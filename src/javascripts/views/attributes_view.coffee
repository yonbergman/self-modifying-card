class App.Views.AttributesView extends Backbone.View
  className: 'attributes'
  template: _.template("""
  <div class="form-group">
    <label for="name" class="col-sm-3 control-label">Name:</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="name" placeholder="Name">
    </div>
  </div>
  <div class="form-group subtitle">
    <label for="subtitle" class="col-sm-3 control-label">Subtitle:</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="subtitle" placeholder="Subtitle">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-9 col-sm-offset-3">
      <div class="checkbox">
        <label>
          <input type="checkbox" id="unique"> Is Unique
        </label>
      </div>
    </div>
  </div>
  <div class="form-group influence">
    <label for="influence" class="col-sm-3 control-label">Influence:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="influence" placeholder="Influence" min="0" max="5">
    </div>
  </div>
  <div class="form-group">
    <label for="type" class="col-sm-3 control-label">Types:</label>
    <div class="col-sm-9">
      <input type="text" class="form-control" id="type" placeholder="Type">
    </div>
  </div>
  <div class="form-group price">
    <label for="price" class="col-sm-3 control-label">Cost:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="price" placeholder="Cost">
    </div>
  </div>
  <div class="form-group link">
    <label for="link" class="col-sm-3 control-label">Link:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="link" placeholder="">
    </div>
  </div>
  <div class="form-group min-deck">
    <label for="min-deck" class="col-sm-3 control-label">Minimum Deck Size:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="min-deck" placeholder="">
    </div>
  </div>
  <div class="form-group max-influence">
    <label for="max-influence" class="col-sm-3 control-label">Maximum Influence:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="max-influence" placeholder="">
    </div>
  </div>
  <div class="form-group mu">
    <label for="mu" class="col-sm-3 control-label">MU:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="mu" placeholder="MU">
    </div>
  </div>
  <div class="form-group strength">
    <label for="strength" class="col-sm-3 control-label"><%= App.Models.Card.strengthMeaning[kind]%>:</label>
    <div class="col-sm-5">
      <input type="number" class="form-control" id="strength" placeholder="Strength">
    </div>
  </div>
  <div class="form-group">
    <label for="text" class="col-sm-3 control-label">Text: <i class="text-help glyphicon glyphicon-question-sign"></i></label>
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
  <div class="form-group upload">
    <label for="image" class="col-sm-3 control-label">Image:</label>
    <div class="col-sm-9">
      <input type="file" id="image" class='form-control'>
    </div>
  </div>
  <div class="col-sm-9 col-sm-offset-3"><p>For a great source of images that fit the Netrunner theme check out <a href="https://www.facebook.com/threyda/photos_stream" target="_blank">Thredya</a></a></p></div>
""")

  initialize: (@options)->
    @model.on('change:kind', @render)

  events:
    'keyup input': 'updateContent'
    'change input': 'updateContent'
    'change textare': 'updateContent'
    'keyup textarea': 'updateContent'
    'change .upload input': 'imageReady'
    'focus #text': -> @$el.find('.text-help').popover('show')
    'blur #text': -> @$el.find('.text-help').popover('hide')

  render: =>
    @$el.html(@template(@model.attributes))
    @$el.find("input, textarea").each (idx, el) =>
      unless el.id == 'image'
        $(el).val(@model.get(el.id))
    @$el.find('#unique').prop('checked', @model.get('unique'))
    @$el.find('.subtitle').hide() unless @isIdentity()
    @$el.find('.strength').hide() unless @hasStrength()
    @$el.find('.price').hide() unless !@isIdentity()
    @$el.find('.link').hide() unless @isIdentity() and @model.isRunner()
    @$el.find('.min-deck').hide() unless @isIdentity()
    @$el.find('.max-influence').hide() unless @isIdentity()
    @$el.find('.mu').hide() unless @hasMU()
    @$el.find('.influence').hide() unless @model.hasInfluence()
    @$el.find('.text-help').popover(
      placement: 'left'
      trigger: 'hover'
      html: true
      title: 'Adding Icons'
      container: 'body'
      content: """
<p>You can add icons by using the following phrases</p>
<dl class="dl-horizontal">
  <dt><i class="icon icon-click"></i></dt><dd>[click]</dd>
  <dt><i class="icon icon-credit"></i></dt><dd>[credit]</dd>
  <dt><i class="icon icon-subroutine"></i></dt><dd>[sub] or --></dd>
  <dt><i class="icon icon-recurring-credit"></i></dt><dd>[recurring]</dd>
  <dt><i class="icon icon-trash"></i></dt><dd>[trash]</dd>
  <dt><i class="icon icon-link"></i></dt><dd>[link]</dd>
  <dt><i class="icon icon-mu"></i></dt><dd>[mu]</dd>
  <dt><i class="icon icon-1mu"></i></dt><dd>[1mu]</dd>
  <dt><i class="icon icon-2mu"></i></dt><dd>[2mu]</dd>
</dl>
      """
    )
    @

  hasStrength: =>
    App.Models.Card.strengthMeaning[@model.get('kind')]

  hasMU: =>
    @model.get('kind')=='program'

  isIdentity: =>
    @model.get('kind')=='identity'

  updateContent: (ev) =>
    el = $(ev.target)
    val = el.val()
    val = el.prop('checked') if el.attr('type') == 'checkbox'
    @model.set(el.get(0).id, val)

  imageReady: (ev) =>
    selectedFile = event.target.files[0];
    reader = new FileReader();
    reader.onload = =>
      @model.set('img', reader.result)
    reader.readAsDataURL(selectedFile)
