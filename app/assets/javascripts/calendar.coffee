updateEvent = undefined
console.log 'document ready'
$(document).on 'page:change', ->
  todayDate = new Date
  todayDate.setHours 0, 0, 0, 0
  $('#calendar').fullCalendar
    editable: true
    slotEventOverlap: false
    firstDay: 1
    selectable: true
    selectHelper: true
    select: (start, end) ->
      user_name = undefined
      user_name = prompt('User name: ')
      eventData = undefined
      #this validates that the user must insert a name in the input
      if user_name
        eventData =
          title: 'Reserved'
          start: start
          end: end
          user_name: user_name
        #here i validate that the user can't create an event before today
        if eventData.start < todayDate
          alert 'You cant choose a date that already past.'
          $('#calendar').fullCalendar 'unselect'
          return
        #if everything it's ok, then the event is saved in database with ajax
        $.ajax
          url: 'events'
          type: 'POST'
          data: eventData
          dataType: 'json'
          success: (json) ->
            alert json.msg
            $('#calendar').fullCalendar 'renderEvent', eventData, true
            $('#calendar').fullCalendar 'refetchEvents'
            return
      $('#calendar').fullCalendar 'unselect'
      return
    defaultView: 'Month'
    allDaySlot: false
    height: 500
    slotMinutes: 30
    eventSources: [{url: '/events'}]
    timeFormat: 'h:mm t{ - h:mm t} '
    dragOpacity: '0.5'
  return
$('#calendar').fullCalendar()
