function js(){
  $('#calendar').fullCalendar({
    defaultView: "agendaWeek", 
    theme: true,
    height: "auto",
    themeButtonIcons: false,
    header: {
      left: 'today prev,next',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab'],
    monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
    monthNames: ['Janeiro', 'Fevereiro', 'Marco', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
    allDaySlot: false,
    slotDuration: "01:00:00",
    axisFormat: 'HH:mm',
    timeFormat: 'HH:mm',
    titleFormat: 'MMMM YYYY',
    //minTime: gon.mintime,
    //maxTime: gon.maxtime,
    minTime: gon.calendar_hours[0],
    maxTime: gon.calendar_hours[1],
    scrollTime: "00:00:00",
    views: {
      week: {
        columnFormat: 'ddd D'
      }
    },
    buttonText: { 
      prev: '<',
      next: '>',
      today: 'hoje',
      month: 'mes',
      week: 'semana',
      day: 'dia'
    },
    events: '/fullcalendar_events.json',
      eventColor: '#1484E6'
  
  });

  var subjectNames = new Array();
  var subjectGrades = new Array();
  var averageGrades = new Array();

  for(var i = 0; i < gon.subjects.length; i++){
    subjectNames.push(gon.subjects[i].name)
    if (gon.subjects[i].value == 0) {
      subjectGrades.push(gon.subjects[i].grade)
    } else {
      subjectGrades.push((100 * gon.subjects[i].grade)/gon.subjects[i].value)
    }
    averageGrades.push(60)
  };

  data = {
    labels : subjectNames,
    datasets : [
      {
        fillColor : "rgba(100,100,180,0.5)",
        strokeColor : "#1484E6",
        pointColor : "#1484E6",
        pointStrokeColor : "#fff",
        data : subjectGrades
      },
      //{
      //  fillColor : "rgba(100,100,180,0.5)",
      //  strokeColor : "rgba(100,100,180,1)",
      //  pointColor : "rgba(100,100,180,1)",
      //  pointStrokeColor : "#fff",
      //  data : subjectGrades
      //},
      {
        fillColor : "rgba(220,50,50,0.3)",
        strokeColor : "#E69700",
        pointColor : "rgba(0,0,0,0)",
        pointStrokeColor : "rgba(0,0,0,0)",
        data : averageGrades
      }
      //{
      //  fillColor : "rgba(220,50,50,0.3)",
      //  strokeColor : "rgba(220,50,50,1)",
      //  pointColor : "rgba(0,0,0,0)",
      //  pointStrokeColor : "rgba(0,0,0,0)",
      //  data : averageGrades
      //}
      //{
      //  fillColor : "rgba(220,50,50,0.3)",
      //  strokeColor : "rgba(220,50,50,1)",
      //  pointColor : "rgba(220,50,50,1)",
      //  pointStrokeColor : "#fff",
      //  pointDot: false,
      //  data : averageGrades
      //}
    ]
  }

  var ctx = document.getElementById("canvas").getContext("2d");
  var pixelRatio = window.devicePixelRatio || 1;
  var width = $('canvas').parent().width();
  var height = $('canvas').parent().height();
  ctx.canvas.width = width / pixelRatio;
  ctx.canvas.height = (1.5 * height) / pixelRatio;
  var myNewChart = new Chart(ctx).Line(data);

  var options = {
    scaleOverride   : true,
    scaleSteps      : 10,
    scaleStepWidth  : 10,
    scaleStartValue : 0,
    datasetFill : false,
    //responsive: true,
    //maintainAspectRatio: true
  }

  new Chart(ctx).Line(data, options);
};
jQuery(document).on("ready page:change", function() { js() })
