$(document).on 'turbolinks:load', ->
  if $('#test_question-sortable').length > 0
    table_width = $('#test_question-sortable').width()
    cells = $('.table').find('tr')[0].cells.length
    desired_width = table_width / cells + 'px'
    $('.table td').css('width', desired_width)

    $('#test_question-sortable').sortable(
      axis: 'y'
      items: '.item'
      cursor: 'move'

      sort: (e, ui) ->
        ui.item.addClass('active-item-shadow')
      stop: (e, ui) ->
        ui.item.removeClass('active-item-shadow')
        # highlight the row on drop to indicate an update
        ui.item.children('td').effect('highlight', {color: "#17a2b8"}, 1000)
      update: (e, ui) ->
        item_id = ui.item.data('item-id')
        test_id = ui.item.data('test-id')
        console.log(item_id)
        position = ui.item.index()
        $.ajax(
          type: 'POST'
          url: '/tests/'+test_id+'/test_questions/update_row_order'
          dataType: 'json'
          data: { test_question: {test_question_id: item_id, row_order_position: position-1 } }
        )
    )
