$(document).on 'turbolinks:load', ->
  if $('#part-sortable').length > 0
    table_width = $('#part-sortable').width()
    cells = $('.table').find('tr')[0].cells.length
    desired_width = table_width / cells + 'px'
    $('.table td').css('width', desired_width)

    $('#part-sortable').sortable(
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
        console.log(item_id)
        position = ui.item.index()
        subject_index = ui.item.data('index')
        $.ajax(
          type: 'POST'
          url: '/parts/update_row_order'
          dataType: 'json'
          data: { part: {part_id: item_id, row_order_position: position-subject_index-1 } }
        )
    )
