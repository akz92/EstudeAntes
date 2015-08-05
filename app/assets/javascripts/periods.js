//function lineChart(){
//  var data = []
//
//  for(var i = 0; i < gon.subjects.length; i++){
//    data.push({
//                value: gon.subjects[i].grade,
//                color:"#1484E6",
//                //highlight: "#FF5A5E",
//                label: gon.subjects[i].name
//              });
//  }
//
//  var ctx = document.getElementById("canvas").getContext("2d");
//  var myNewChart = new Chart(ctx).PolarArea(data);
//
//  var options = {
//    responsive: true,
//    //maintainAspectRatio: true
//  };
//
//  new Chart(ctx).PolarArea(data, options);
//}

function barChart(){
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
        fillColor:"#1484E6",
        data : subjectGrades
      }
    ]
  }

  var ctx = document.getElementById("canvas").getContext("2d");
  var myBarChart = new Chart(ctx).Bar(data);

  var options = {
    barValueSpacing : 30,
    responsive : true,
    //maintainAspectRatio: true
  };

  new Chart(ctx).Bar(data, options);

}
jQuery(document).on("ready page:change", function() { barChart();});
