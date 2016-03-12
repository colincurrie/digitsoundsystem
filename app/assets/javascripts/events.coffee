$(document).on 'page:change', ->
  $('#event_start_at').datetimepicker {theme: 'dark', format: 'd/m/Y H:i'}
  $('#event_end_at').datetimepicker {theme: 'dark', format: 'd/m/Y H:i'}
  todayDate = new Date
  todayDate.setHours 0, 0, 0, 0
  $('#calendar').fullCalendar
    editable: false
    slotEventOverlap: false
    firstDay: 1
    defaultView: 'month'
    header:
      left: 'title'
      center: ''
      right: 'today prev,next'
    allDaySlot: true
    height: 500
    slotMinutes: 60
    eventSources: [{url: '/events.json'}]
    displayEventTime: false
  return
