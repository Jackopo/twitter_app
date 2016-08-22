# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('#loading').hide();

  query = () ->
    $('.search #q').val()

  last_tweet_id = () ->
    $('.search #last_tweet_id').val()

  win = $(window)

  win.scroll () ->

    if ($(document).height() - win.height() == win.scrollTop())
      query = $('.search #q').val()
      last_tweet_id = $('.search #last_tweet_id').val()

      $('#loading').show();

      $.ajax({
        url: "/load_tweets",
        data: {
          q: query,
          last_tweet_id: last_tweet_id
        },
        success: (html) ->
          last_tweet_id = $(html).find('#last_tweet_id').val()
          $('.search #last_tweet_id').val(last_tweet_id)
          $('#tweets-list').append(html)
          $('#tweets-list #last_tweet_id').remove()
          $('#loading').hide()

      })
