<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>dbIS</title>
 <!-- Bootstrap core CSS-->
    <link href="dbanalyzer/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="dbanalyzer/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="dbanalyzer/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="dbanalyzer/css/sb-admin.css" rel="stylesheet">
</head>
<body>
 <div class="col-lg-8">
              <div class="card mb-3">
                <div class="card-header">
                  <i class="fas fa-chart-bar"></i>
                  Portfolio Composition </div>
                <div class="card-body">
                  <canvas id="myBarChart" width="100%" height="50"></canvas>
                </div>
         
              </div>
            </div>
</body>
 <!-- Bootstrap core JavaScript-->
    <script src="dbanalyzer/vendor/jquery/jquery.min.js"></script>
    <script src="dbanalyzer/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="dbanalyzer/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="dbanalyzer/vendor/chart.js/Chart.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="dbanalyzer/js/sb-admin.min.js"></script>


<script>
var rootURL = "rws/services";

//Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

pullfromtable();
function pullfromtable(){
//	formdata = $('#tables');
//	fds = formdata.serialize();
//	console.log(fds);
	
	var request = $.ajax({
		method: 'GET',
		url: rootURL + '/ibs',
		dataType: "json", // data type of response
		//data: ,
                
		success: function (result) {
			console.log(result);
			//var names = new Array();
			var ctx = document.getElementById("myBarChart");
			var sell = new Array();
			var buy = new Array();
			var names = new Array();
			for(var x = 0; x < result.length; x++){
				if (x%2 == 0){
					names.push(result[x][0]);
				}
				if (result[x][1] === "B" ) {
					buy.push(result[x][2]);
				}
				else if (result[x][1] === "S") {
					sell.push(result[x][2]);
				}
			}
			
			/* console.log("names " + names);
			console.log("buy" + buy);
			console.log("sell" + sell); */
			
			var myLineChart = new Chart(ctx, {
			  type: 'bar',
			  data: {
			    labels: names,//["Astronomica", "Deuteronic", "Floral", "Galactic","Celestrial","Heliosphere","Jupiter","Interstella","Koronis","Eclipse","Borealis","Lunatic"],
			    datasets: [{
			      label: "Total Sell",
			      backgroundColor: "rgba(2,117,216,1)",
			      borderColor: "rgba(2,117,216,1)",
			      // This needs to be set up so that it uses data from database
			      data: sell//[4440, 5312, 6251, 7841, 9821, 6984,1000,4000,3000,4200,9000,1500],
			    },
			    {
			      label: "Total buy",
			      backgroundColor: "rgba(100,217,216,1)",
			      borderColor: "rgba(100,117,216,1)",
			      // This needs to be set up so that it uses data from database
			      data: buy//[8840, 5312, 6251, 7841, 9821, 6984,1000,4000,3000,4200,9000,1500],
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
			          maxTicksLimit: 14
			        }
			      }],
			      yAxes: [{
			        ticks: {
			          min: 0,
			          max: 30000000000,
			          maxTicksLimit: 20
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
			
		}
	})
} 
// Bar Chart Example


</script>
</html>