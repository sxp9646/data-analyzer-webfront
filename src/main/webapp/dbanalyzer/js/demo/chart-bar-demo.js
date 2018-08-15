// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Bar Chart Example
var ctx = document.getElementById("myBarChart");
var myLineChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ["Astronomica", "Deuteronic", "Floral", "Galactic","Celestrial","Heliosphere","Jupiter","Interstella","Koronis","Eclipse","Borealis","Lunatic"],
    datasets: [{
      label: "Total Long Postion",
      backgroundColor: "rgba(2,117,216,1)",
      borderColor: "rgba(2,117,216,1)",
      // This needs to be set up so that it uses data from database
      data: [4440, 5312, 6251, 7841, 9821, 6984,1000,4000,3000,4200,9000,1500],
    },
    {
      label: "Total Short Position",
      backgroundColor: "rgba(100,217,216,1)",
      borderColor: "rgba(100,117,216,1)",
      // This needs to be set up so that it uses data from database
      data: [8840, 5312, 6251, 7841, 9821, 6984,1000,4000,3000,4200,9000,1500],
    }
  
  ],
  },
  options: {
    scales: {
      xAxes: [{
        time: {
          unit: 'company'
        },
      //  stacked: true,
        gridLines: {
          display: false
        },
        ticks: {
          maxTicksLimit: 12
        }
      }],
      yAxes: [{
        ticks: {
          min: 0,
          max: 12000,
          maxTicksLimit: 5
        },
    //    stacked: true,
        gridLines: {
          display: true
        }
      }],
    },
    legend: {
      display: false
    }
  }
});