<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Tables</title>

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

    <!-- Bootstrap core JavaScript-->
    <script src="dbanalyzer/vendor/jquery/jquery.min.js"></script>
    <script src="dbanalyzer/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="dbanalyzer/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="dbanalyzer/vendor/datatables/jquery.dataTables.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="dbanalyzer/js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="dbanalyzer/js/demo/datatables-demo.js"></script>
    

  </head>

  <body id="page-top" style="zoom:125%;">
  <!--  blabla -->
  
	      <nav class="navbar navbar-expand navbar-dark bg-dark static-top"  style="margin-bottom: 0px; border-radius: 0px; height: 12px;">
	
	      <a class="navbar-brand mr-1" style="font-size:17px; padding:12px;" href="index.jsp" >dbIS</a>
	
	
	
	      <!-- Navbar -->
	      <ul class="navbar-nav ml-auto ml-md-0">
	      </ul>
	
	  	  </nav>
	  	  
	  <div id="wrapper">

      <!-- Sidebar -->
      <ul class="sidebar navbar-nav" style="font-size: 20px; padding:10px;">
      
        <li class="nav-item">
          <a class="nav-link" href="markets.jsp">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Markets</span>
          </a>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="charts.jsp">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>Charts</span></a>
        </li>

        <li id="tables" class="nav-item active">
          <a class="nav-link" href="datatable.jsp">
            <i class="fas fa-fw fa-table"></i>
            <span >Tables</span></a>
        </li> 
      </ul>

      <div id="content-wrapper">
      	<div class="container-fluid">

          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              Deals</div>
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
        

        </div>
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright © Deutsche Bank 2018</span>
            </div>
          </div>
        </footer>
   
      <!-- /.content-wrapper -->
      </div>

 </div>
    <!-- /#wrapper -->

     


    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

  
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
            					
            					 var data = [];
							        for ( var i=0 ; i<100000 ; i++ ){
							        	data.push( [
							            	'<td>' + result[i][0] +  '</td>',
							            	'<td>' + result[i][1] +  '</td>',
							            	'<td>' + result[i][2] +  '</td>',
							            	'<td>' + result[i][3] +  '</td>',
							            	'<td>' + result[i][4] +  '</td>',
							            	'<td>' + result[i][5] +  '</td>',
							            	'<td>' + result[i][6] +  '</td>', 
							            	] ); 
							        }
							        console.log(data);
							        $('#data_table').DataTable({
							        	data:           data,
							        	deferRender:    false,
							        	scrollY:        200,
							        	scrollCollapse: false,
							        	scroller:       false
							            } ); 
            						/* var table_data = '';
            		                $.each(result, function(key, value) {
            		              
            		                  table_data += '<tr>';
            		                  table_data += '<td>' + value[0] +  '</td>';
            		                  table_data += '<td>' + value[1] +  '</td>';
            		                  table_data += '<td>' + value[2] +  '</td>';
            		                  table_data += '<td>' + value[3] +  '</td>';
            		                  table_data += '<td>' + value[4] +  '</td>';
            		                  table_data += '<td>' + value[5] +  '</td>';
            		                  table_data += '<td>' + value[6] +  '</td>';
            						          table_data += '</tr>';
            		                }); */
            		            //$('#data_table').append(table_data).DataTable();
            		            
            		           
            		              }
            		            
            		            });
            			}
            </script>

   </body>
</html>