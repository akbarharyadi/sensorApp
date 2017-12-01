$(document).on 'turbolinks:load', ->
  $('#menu-toggle').click (e) ->
    e.preventDefault()
    $('#wrapper').toggleClass 'toggled'
    return