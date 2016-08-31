# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$('select#list_query').on 'change', (event) ->

  query = $(this).val()

  console.log 'i am changing in ' + query

  source = new EventSource("map_page/stream_tweets?list_query=#{query}")

  source.addEventListener("tweet", (event) ->
    $('#tweets').find('#tweets-list').prepend(event.data)
  )

  source.onopen = (e) ->
    console.log 'I am open'
    console.log e

  source.onmessage = (e) ->
    console.log e

  source.onerror = (e) ->
    console.log e
    this.close()

  # $.ajax({
  #   url: "map_page/stream_tweets",
  #   data: {
  #     list_query: query
  #   },
  #   success: (data) ->
  #     console.log data
  #     $('#tweets').find('#tweets-list').prepend($.parseHTML(data))
  #   error: (data, error) ->
  #     console.log data
  #     console.log error
  #   complete: (data) ->
  #     console.log data
  # })
