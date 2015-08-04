function lineChart(){
  var subjectNames = [];
  var subjectGrades = [];
  var averageGrades = [];

  for(var i = 0; i < gon.subjects.length; i++){
    subjectNames.push(gon.subjects[i].name);
    if (gon.subjects[i].value === 0) {
      subjectGrades.push(gon.subjects[i].grade);
    } else {
      subjectGrades.push((100 * gon.subjects[i].grade)/gon.subjects[i].value);
    }
    averageGrades.push(60);
  }

  var data = {
    labels : subjectNames,
    datasets : [
      {
        fillColor : "rgba(100,100,180,0.5)",
        strokeColor : "#1484E6",
        pointColor : "#1484E6",
        pointStrokeColor : "#fff",
        data : subjectGrades
      },
      {
        fillColor : "rgba(220,50,50,0.3)",
        strokeColor : "#E69700",
        pointColor : "rgba(0,0,0,0)",
        pointStrokeColor : "rgba(0,0,0,0)",
        data : averageGrades
      }
    ]
  };

  var ctx = document.getElementById("canvas").getContext("2d");
  var myNewChart = new Chart(ctx).Line(data);

  var options = {
    scaleOverride   : true,
    scaleSteps      : 10,
    scaleStepWidth  : 10,
    scaleStartValue : 0,
    datasetFill : false,
    responsive: true,
    //maintainAspectRatio: true
  };

  new Chart(ctx).Line(data, options);
}
jQuery(document).on("ready page:change", function() { lineChart();});
