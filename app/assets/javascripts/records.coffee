# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class @Records
  # java script test for this code suck. Still experimenting with how to deal with JS tests
  # TODO: make this sort of test better. expected results TRUE or FALSE
  # TODO: This also could be reused move it to a new function
  checkLoadMoreItems: ->
    load_more = document.getElementById('load-more-records')
    return if load_more == null
    window_size = window.innerHeight
    scroll_position = window.pageYOffset
    load_more_postion = load_more.offsetTop
    bottom = scroll_position + window_size
    bottom >= load_more_postion && load_more.dataset.loadingInProgress != 'true'

  removeCurrentLoadingMore: ->
    document.getElementById('load-more-records').remove()

  appendRecordToTable: (row) ->
    table_body = document.getElementById('table-records-body')
    table_body.insertAdjacentHTML('beforeend', row)

  loadMore: ->
    load_more_records = document.getElementById('load-more-records')
    query = document.getElementById('search_term').value
    load_more_records.dataset.loadingInProgress = 'true'
    $.ajax
      url: '/records'
      dataType: 'script'
      data:
        search:
          query: query
        page: load_more_records.dataset.page

  checkAndLoadMore: ->
    this.loadMore() if this.checkLoadMoreItems()

document.addEventListener 'turbolinks:load', ->
  new Records().checkAndLoadMore()
document.addEventListener 'scroll', ->
  new Records().checkAndLoadMore()

