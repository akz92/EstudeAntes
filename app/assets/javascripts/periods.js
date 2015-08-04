function lineChart(){
  var data = []

  for(var i = 0; i < gon.subjects.length; i++){
    data.push({
                value: gon.subjects[i].grade,
                color:"#F7464A",
                highlight: "#FF5A5E",
                label: gon.subjects[i].name
              });
  }

  var ctx = document.getElementById("canvas").getContext("2d");
  var myNewChart = new Chart(ctx).PolarArea(data);

  var options = {
    responsive: true,
    //maintainAspectRatio: true
  };

  new Chart(ctx).PolarArea(data, options);
}
jQuery(document).on("ready page:change", function() { lineChart();});
