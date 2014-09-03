class App.Views.SaveImageView extends Backbone.View

  el: '.card-view'

  events:
    'click .generate-image': 'generateImage'

  ## RENDER IMAGE
  generateImage: (ev) =>
    html2canvas @$el.find('.card'),
      allowTaint: true
      onrendered: (canvas) =>
        imageData = canvas.toDataURL("image/png");
        cardname = @model.get('name').replace(/[^a-z0-9]/gi, '_').toLowerCase()
        @$el.find('a').attr(href :imageData, download: "netrunner-#{cardname}.png").removeClass('disabled')
