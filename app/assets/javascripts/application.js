
//= require jquery.min
//= require jquery-ui/jquery-ui.min
//= require jquery.turbolinks
//= require bootstrap.min
//= require jquery_ujs

//= require detect
//= require fastclick
//= require jquery.slimscroll
//= require jquery.blockUI
//= require waves
//= require wow.min
//= require jquery.nicescroll
//= require jquery.scrollTo.min
//= require peity/jquery.peity.min
//= require jquery-sparkline/jquery.sparkline.min
//= require custombox/dist/custombox.min
//= require custombox/dist/legacy.min

//= require jquery.core
//= require jquery.app

//= require moment/moment

//= require bootstrap-inputmask/bootstrap-inputmask.min
//= require bootstrapvalidator/dist/js/bootstrapValidator
//= require autoNumeric/autoNumeric
//= require bootstrap-table/dist/bootstrap-table
//= require datatables/jquery.dataTables.min
//= require datatables/dataTables.bootstrap
//= require tiny-editable/mindmup-editabletable
//= require tiny-editable/numeric-input-example
//= require bootstrap-table/dist/bootstrap-table.min
//= require fullcalendar/dist/fullcalendar.min
//= require fullcalendar/dist/lang/pt-br
//= require jquery.fullcalendar
//= require parsleyjs/dist/parsley.min

//= require jquery.steps/build/jquery.steps.min
//= require jquery-validation/dist/jquery.validate.min
//= require jquery.wizard-init

//= require timepicker/bootstrap-timepicker.min
//= require bootstrap-datepicker/dist/js/bootstrap-datepicker.min

//= require x-editable/dist/bootstrap3-editable/js/bootstrap-editable.min

//= require waypoints/lib/jquery.waypoints
//= require counterup/jquery.counterup.min

//= require sweetalert/dist/sweetalert.min

//= require morris/morris.min
//= require raphael/raphael-min
//= require Chart.js/Chart.min

//= require jquery-knob/jquery.knob


function formatDateObj(dateObject) {
    var d = new Date(dateObject);
    var day = d.getDate() + 1;
    var month = d.getMonth() + 1;
    var year = d.getFullYear();
    if (day < 10) {
        day = "0" + day;
    }
    if (month < 10) {
        month = "0" + month;
    }
    var date = day + "/" + month + "/" + year;

    return date;
};

function addMonth(month){
  var actual = month.split("-");

  day = actual[2];
  if (parseInt(actual[1]) == 12) {
    month = 1;
    year = parseInt(actual[0]) + 1;
  } else {
    month = parseInt(actual[1]) + 1;
    year = actual[0];
  }

  if (month < 10) {
    month = "0" + month;
  }

  return nextDate = year + "-" + month + "-" + day;
}

function formatDate(data){
  var dia = data.getDate();
  if (dia.toString().length == 1)
    dia = "0"+dia;
  var mes = data.getMonth()+1;
  if (mes.toString().length == 1)
    mes = "0"+mes;
  var ano = data.getFullYear();
  return mes+"/"+dia+"/"+ano;
}

function formatDateBR(data){
  console.log(data);
  var dia = data.getDate();
  if (dia.toString().length == 1)
    dia = "0"+dia;
  var mes = data.getMonth() + 2;
  if (mes.toString().length == 1)
    mes = "0"+mes;
  var ano = data.getFullYear();
  return "01/"+mes+"/"+ano;
}

function formatToInit(date){
  var date = date.split("/");

  day = date[0];
  month = date[1];
  year = date[2]

  return year + "-" + month + "-" + day;
}

function monthDiff(d1, d2) {
  var months;

  months = (d2.getFullYear() - d1.getFullYear()) * 12;
  months -= d1.getMonth() + 1;
  months += d2.getMonth();

  return months <= 0 ? 0 : months;
}

function ReplaceNumberWithCommas(myNumber) {
  var n = myNumber.toString().split(".");

  n[1] = n[1].replace(/\B(?=(\d{3})+(?!\d))/g, ",");

  return n;
}

function time_format(dateObject) {
  var d = new Date(dateObject);
  hours = format_two_digits(d.getHours() + 3);
  minutes = format_two_digits(d.getMinutes());
  return hours + ":" + minutes;
}

function addHour(dateObject) {
  var d = new Date(dateObject);
  hours = format_two_digits(d.getHours() + 4);
  minutes = format_two_digits(d.getMinutes());
  return hours + ":" + minutes;
}

function removeHour(dateObject) {
  var d = new Date(dateObject);
  hours = format_two_digits(d.getHours() - 3);

  minutes = format_two_digits(d.getMinutes());
  return hours + ":" + minutes;
}

function format_two_digits(n) {
  return n < 10 ? '0' + n : n;
}

$(document).ready(function(){
  $('form').parsley();
})

$.turbo.use('turbolinks:load', 'turbolinks:request-start')
