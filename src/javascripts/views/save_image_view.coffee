class App.Views.SaveImageView extends Backbone.View

  el: '.card-view'

  events:
    'click .save-image': 'saveImage'

  ## RENDER IMAGE
  saveImage: (ev) =>
    html2canvas @$el.find('.card'),
      allowTaint: true
      width: 100
      height: 100
      onrendered: (canvas) ->
        $("body").append(canvas)