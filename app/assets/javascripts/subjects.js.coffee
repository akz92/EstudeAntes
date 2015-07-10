# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = undefined
ready = ->
  $(".tiptext").mouseover(->
    $(this).children(".description").show()
    return
  ).mouseout ->
    $(this).children(".description").hide()
    return

$("#").on "change", ->
  $("#esatu").toggle $(this).hasClass("relat__atu_yes")
  return

