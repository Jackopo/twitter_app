# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$('select#list_query').on 'change', (event) ->
  console.log 'i am changing in ' + $(this).val()
  query = $(this).val()

  $.ajax({
    url: "/map_page/show",
    data: {
      list_query: query
    },
    success: (data) ->
      tweets = $.parseJSON(data)
      $('#tweets').append(tweets.tweets)
  })
