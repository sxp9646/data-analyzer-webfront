<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin - Tables</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Bootstrap core CSS-->
    <link href="dbanalyzer/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="dbanalyzer/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="dbanalyzer/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="dbanalyzer/css/sb-admin.css" rel="stylesheet">

  </head>

  <body id="page-top">
  
	      <nav class="navbar navbar-expand navbar-dark bg-dark static-top">
	
	      <a class="navbar-brand mr-1" href="index.html">dbRobinhood</a>
	
	      <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle">
	        <i class="fas fa-bars"></i>
	      </button>
	
	
	      <!-- Navbar -->
	      <ul class="navbar-nav ml-auto ml-md-0">
	      </ul>
	
	  	  </nav>
	  	  
	  	     <div id="wrapper">

      <!-- Sidebar -->
      <ul class="sidebar navbar-nav">
      
        <li class="nav-item">
          <a class="nav-link" href="index.html">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span>
          </a>
        </li>

        <li class="nav-item active">
          <a class="nav-link" href="charts.html">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Charts</span></a>
        </li>

        <li id="tables" onclick="tablesclick()" class="nav-item">
          <a class="nav-link" href="datatable.jsp">
            <i class="fas fa-fw fa-table"></i>
            <span >Tables</span></a>
        </li> 
      </ul>

      <div id="content-wrapper">

          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              Data Table Example</div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="data_table">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Time</th>
                      <th>Counterparty ID</th>
                      <th>Instrument ID</th>
                      <th>Type</th>
                      <th>Amount</th>
                      <th>Quantity</th>
                    </tr>
					</thead>
					<tbody>
					</tbody>
                </table>
              </div>
            </div>
          </div>

          </body>

          <script>
           // $(document).ready(function() {
        	   var rootURL = "rws/services";

            	pullfromtable("deals", "");
            	function pullfromtable(tableName, filters){
//            		formdata = $('#tables');
//            		fds = formdata.serialize();
//            		console.log(fds);
            		var data1 = "tableName=" + tableName + "&filters=" + filters;
            		console.log(data1)
            		var request = $.ajax({
            			method: 'GET',
            			url: rootURL + '/tables2',
            			dataType: "json", // data type of response
            			data: data1,
            	                
            			success: function (result) {
            						console.log('hello world');
            						console.log(result);   
            						var table_data = '';
            		                $.each(result, function(key, value) {
            		                  // console.log(key);
            						          //console.log(value);

            		                  table_data += '<tr>';
            		                  table_data += '<td>' + value[0] +  '</td>';
            		                  table_data += '<td>' + value[1] +  '</td>';
            		                  table_data += '<td>' + value[2] +  '</td>';
            		                  table_data += '<td>' + value[3] +  '</td>';
            		                  table_data += '<td>' + value[4] +  '</td>';
            		                  table_data += '<td>' + value[5] +  '</td>';
            		                  table_data += '<td>' + value[6] +  '</td>';
            						          table_data += '</tr>';

            		                });
            		            $('#data_table').append(table_data).DataTable();
            		           
            		              }
            		            
            		            });
            			}
            		//})
              /* $.getJSON("tableinfo.json", function(data){
                var table_data = '';
                $.each(data, function(key, value) {
                  // console.log(key);
				          //console.log(value);

                  table_data += '<tr>';
                  table_data += '<td>' + value[0] +  '</td>';
                  table_data += '<td>' + value[1] +  '</td>';
                  table_data += '<td>' + value[2] +  '</td>';
                  table_data += '<td>' + value[3] +  '</td>';
                  table_data += '<td>' + value[4] +  '</td>';
                  table_data += '<td>' + value[5] +  '</td>';
                  table_data += '<td>' + value[6] +  '</td>';
				          table_data += '</tr>';

                });
            $('#data_table').append(table_data).DataTable();
           
              });
            
            }); */
            </script>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>



    <!-- Bootstrap core JavaScript-->
    <script src="dbanalyzer/vendor/jquery/jquery.min.js"></script>
    <script src="dbanalyzer/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="dbanalyzer/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="dbanalyzer/vendor/datatables/jquery.dataTables.js"></script>
    <script src="dbanalyzer/vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="dbanalyzer/js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="dbanalyzer/js/demo/datatables-demo.js"></script>

  </body>

</html>
