
$(document).ready(function() {

  $("#danger-alert").hide();

!function($) {
    "use strict";

    var CalendarApp = function() {
        this.$body = $("body")
        this.$modal = $('#event-modal'),
        this.$event = ('#external-events div.external-event'),
        this.$calendar = $('#calendar'),
        this.$saveCategoryBtn = $('.save-category'),
        this.$categoryForm = $('#add-category form'),
        this.$extEvents = $('#external-events'),
        this.$calendarObj = null
    };

    var currDate, objectId, objectType, selectedId;

    /* on drop */
    CalendarApp.prototype.onDrop = function (eventObj, date) {
        var $this = this;

        // retrieve the dropped element's stored Event Object
        var originalEventObject = eventObj.data('eventObject');
        
        $("#time_initial").val(date.format("HH:mm"));

        $("#time_final").val(addHour(date));
        
        var $categoryClass = eventObj.attr('data-class');
        // we need to copy it, so that multiple events don't have a reference to the same object
        var copiedEventObject = $.extend({}, originalEventObject);
        // assign it the date that was reported

        $this.$modal.modal('show');

        $("#process").val(eventObj.data('name'))
        currDate = date.format("YYYY-MM-DD");
        objectId = eventObj.data('code');
        objectType = eventObj.data('object');
    },
    /* on click on event */
    CalendarApp.prototype.onEventClick =  function (calEvent, jsEvent, view) {

      var $this = this;
      var initHour = time_format(calEvent.start_moment);

      selectedId = calEvent.id;
      
      $("#event-detail-modal").modal({
          backdrop: 'static'
      });

      $.ajax({
        type: "GET",
        url: "/appointments/get_appointment",
        data: {
          "id": calEvent.id
        },
        success: function(data){
          var infoData = "";
          $("#content-info").html('');

          infoData = "<h5 style='text-align: center'><b>DADOS DO COMPROMISSO</b></h5>\
                      <h5>Data: <b>" + calEvent.start.format("DD/MM/YYYY") + "</b></h5>\
                      <h5>Início: <b>" + time_format(calEvent.start_moment) + "</b></h5>\
                      <h5>Término: <b>" + time_format(calEvent.end_moment) + "</b></h5>\
                      <hr>";

          if (calEvent.appointment_type == 'process') {
            infoData += "<h5 style='text-align: center'><b>DADOS DO PROCESSO</b></h5> \
                          <h5>Nome: <b>" + data.name + "</b></h5><h5>Área: <b>" + data.area_name + "</b></h5>";
          } else if (calEvent.appointment_type == 'contract') {
            infoData += "<h5 style='text-align: center'><b>DADOS DO CONTRATO</b></h5> \
                          <h5>Contrato: <b>" + data.name + "</b></h5>\
                          <h5>Cliente: <b>" + data.client_name + "</b></h5>\
                          <h5>Escopo: <b>" + data.scope + "</b></h5>\
                          <h5>Tipo: <b>" + data.contract_type + "</b></h5>\
                          <h5>Data de assinatura: <b>" + formatDateObj(data.signature_date) + "</b></h5>\
                          <hr>\
                          <h5 style='text-align: center'><b>CONTROLE DE HORAS</b></h5>\
                          <h5>Modelo de atribuição: <b>" + data.attribuition_model + "</b></h5>\
                          <h5>Volume de tickets: <b>" + data.hours_volume + "</b></h5>\
                          <h5>Valor do ticket: <b>" + data.amount_ticket + "</b></h5>\
                          <h5>Tickes tolerados: <b>" + data.tolerance + "</b></h5>";
          } else if (calEvent.appointment_type == 'project') {
            infoData += "<h5 style='text-align: center'><b>DADOS DO PROJETO</b></h5> \
                          <h5>Projeto: <b>" + data.name + "</b></h5>\
                          <h5>Contrato: <b>" + data.contract_name + "</b></h5>\
                          <h5>Patrocinador: <b>" + data.sponsor + "</b></h5>\
                          <h5>Gerente: <b>" + data.manager + "</b></h5>\
                          <h5>Tipo: <b>" + data.type_project + "</b></h5>\
                          <h5>Área do cliente onde o projeto será executado: <b>" + data.area_name + "</b></h5>\
                          <h5>Orçamento: <b>" + data.estimate + "</b></h5>\
                          <h5>Data de início: <b>" + formatDateObj(data.start_date) + "</b></h5>\
                          <h5>Data de término: <b>" + formatDateObj(data.end_date) + "</b></h5>\
                          <h5>Observações: <b>" + data.obs + "</b></h5>";
          }

          $("#content-info").html(infoData);
        },
        error: function (xhr, ajaxOptions, thrownError) {
          alert(xhr.responseText);
          alert(thrownError);
        }
      });
    },

    $("#delete_appointment").click(function () {
      deleteEvent(selectedId);
    });

    $("#create_appointment").click(function(){
      createEvent(objectId, objectType, currDate);
    });

    function generateEvent(start_moment, end_moment) {

      var $this = this;

      // retrieve the dropped element's stored Event Object
      var originalEventObject = eventObj.data('eventObject');

      var $categoryClass = eventObj.attr('data-class');
      // we need to copy it, so that multiple events don't have a reference to the same object
      var copiedEventObject = $.extend({}, originalEventObject);
      // assign it the date that was reported

      copiedEventObject.start = '2019-02-11 08:45';
      copiedEventObject.end = '2019-02-11 09:55';

      if ($categoryClass)
          copiedEventObject['className'] = [$categoryClass];
      // render the event on the calendar
      $this.$calendar.fullCalendar('renderEvent', copiedEventObject, true);
      // is the "remove after drop" checkbox checked?
      if ($('#drop-remove').is(':checked')) {
          // if so, remove the element from the "Draggable Events" list
          eventObj.remove();
      }
    }

    /* on select */
    CalendarApp.prototype.onSelect = function (start, end, allDay) {
        var $this = this;
            $this.$modal.modal({
                backdrop: 'static'
            });
            
            $this.$modal.find('.delete-event').hide().end().find('.save-event').show().end().find('.modal-body').end().find('.save-event').unbind('click').click(function () {
                var process_appointment = $("#process").val();
                var initial_hour = $("#time_initial").val();
                var final_hour = $("#time_final").val();

                form.submit();
            });

            $this.$modal.find('form').on('submit', function () {
                var process_appointment = $("#process").val();
                var initial_hour = $("#time_initial").val();
                var final_hour = $("#time_final").val();
            });
            $this.$calendarObj.fullCalendar('unselect');
    },
    CalendarApp.prototype.enableDrag = function() {
        //init events
        $(this.$event).each(function () {
            // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
            // it doesn't need to have a start or end
            var eventObject = {
                title: $.trim($(this).text()) // use the element's text as the event title
            };
            // store the Event Object in the DOM element so we can get to it later
            $(this).data('eventObject', eventObject);
            // make the event draggable using jQuery UI
            $(this).draggable({
                zIndex: 999,
                scroll: false,
                helper: 'clone',
                revert: true,      // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            });

            $(this).css("width", '100%')
        });
    }
    /* Initializing */
    CalendarApp.prototype.init = function(data) {

        this.enableDrag();
        /*  Initialize the calendar  */
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var form = '';
        var today = new Date($.now());
        var defaultEvents = [];
        
        for (var i = 0; i < data.length; i++) {
          var color = '';

          if (data[i].appointment_type == 'contract')
            color = 'bg-primary';
          else if (data[i].appointment_type == 'project')
            color = 'bg-success';
          else if (data[i].appointment_type == 'process') 
            color = 'bg-custom';

          var appointment = {
            id: data[i].id,
            title: data[i].name,
            description: data[i].info,
            appointment_type: data[i].appointment_type,
            start: data[i].start_moment,
            end: data[i].end_moment,
            start_moment: data[i].start_moment,
            end_moment: data[i].end_moment,
            className: color
          }
          defaultEvents.push(appointment);
        }

        var $this = this;
        $this.$calendarObj = $this.$calendar.fullCalendar({
            locale:  'pt-br',
            slotDuration: '00:15:00', /* If we want to split day time each 15minutes */
            minTime: '00:00:00',
            maxTime: '24:00:00',
            defaultView: 'agendaDay',
            handleWindowResize: true,
            height: $(window).height(),
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            events: defaultEvents,
            editable: false,
            droppable: true, // this allows things to be dropped onto the calendar !!!
            eventLimit: true, // allow "more" link when too many events
            selectable: false,
            eventRender: function(eventObj, $el) {
              // $el.popover({
              //   title: eventObj.title,
              //   content: eventObj.description,
              //   trigger: 'hover',
              //   placement: 'right',
              //   container: 'body',
              //   html: true
              // });

              // $el.find('.popover-content').html($el.find('.popover-content').text());
            },
            drop: function(date) { $this.onDrop($(this), date); },
            select: function (start, end, allDay) { $this.onSelect(start, end, allDay); },
            eventClick: function(calEvent, jsEvent, view) { $this.onEventClick(calEvent, jsEvent, view); }

        });

        //on new event
        this.$saveCategoryBtn.on('click', function(){
            var categoryName = $this.$categoryForm.find("input[name='category-name']").val();
            var categoryColor = $this.$categoryForm.find("select[name='category-color']").val();
            if (categoryName !== null && categoryName.length != 0) {
                $this.$extEvents.append('<div class="external-event bg-' + categoryColor + '" data-class="bg-' + categoryColor + '" style="position: relative;"><i class="fa fa-move"></i>' + categoryName + '</div>')
                $this.enableDrag();
            }
        });
    },

   //init CalendarApp
    $.CalendarApp = new CalendarApp, $.CalendarApp.Constructor = CalendarApp


}(window.jQuery),

//initializing CalendarApp
function($) {
    "use strict";
    $.ajax({
      url: '/appointments/list_appointment',
      type: 'POST',
      success: function(data){
        $.CalendarApp.init(data)
      }
    });
}(window.jQuery);

});

function createEvent(id, type, date) {
  if ($('#time_initial').val() < $('#time_final').val()) {
   $.ajax({
    type: "GET",
    url: "/appointments/register_appointment",
    data: {
      "id": id,
      "type": type,
      "start": date + " " + $("#time_initial").val(),
      "end": date + " " + $("#time_final").val()
    },
    success: function(doc){
      var events = [];
      var color = '';

      if (type == 'contract')
        color = 'bg-primary';
      else if (type == 'project')
        color = 'bg-success';
      else if (type == 'process')
        color = 'bg-custom';

      events.push({
        id: doc.id,
        title: $("#process").val(),
        start: date + " " + $("#time_initial").val(),
        end: date + " " + $("#time_final").val(),
        start_moment: date + " " + removeHour(date + " " + $("#time_initial").val()),
        end_moment: date + " " + removeHour(date + " " + $("#time_final").val()),
        appointment_type: type,
        className: color
      });
    
      $('#calendar').fullCalendar('addEventSource', events)
      $("#event-modal").modal('hide');
    },
    error: function (xhr, ajaxOptions, thrownError) {
      alert(xhr.responseText);
      alert(thrownError);
    }
  }); 
  } else {
    $("#danger-alert").fadeTo(2000, 500).slideUp(500, function(){
      $("#alert-alert").slideUp(500);
      $("#danger-alert-alert").hide();
    });
  }
}

function deleteEvent(id) {
  $.ajax({
    type: "GET",
    url: "/appointments/delete_appointment",
    data: {
      "id": id
    },
    success: function(doc){
      $('#calendar').fullCalendar('removeEvents', id);
      $("#event-detail-modal").modal('hide');
    },
    error: function (xhr, ajaxOptions, thrownError) {
      alert(xhr.responseText);
      alert(thrownError);
    }
  });
}