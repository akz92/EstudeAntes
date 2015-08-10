$('document').ready(function(){
  var subjectPercentage = Math.round( (gon.subject.grade / gon.subject.value) * 100 );

  if (gon.subject.grade === 0)
  {
    subjectPercentage = 100;
  }

  var data = [
    {
      value : 100 - subjectPercentage,
      color : "#E0E4CC"
    },
    {
      value : subjectPercentage,
      //color : "#69D2E7"
      color : "#3498db"
    }
        ];

  var ctx = document.getElementById("aproveitamento").getContext("2d");
  var myNewChart = new Chart(ctx).Doughnut(data);

  new Chart(ctx).Dounghnut(data);
});
