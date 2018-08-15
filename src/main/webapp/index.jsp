<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="dbanalyzer/css/main.css" />
<link rel="stylesheet" href="dbanalyzer/css/login.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
	
</script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous">
	
</script>
<script src="dbanalyzer/js/main.js"></script>
<title>dbRobinhood</title>
</head>
<body>

	<img src="dbanalyzer/js/db.gif" alt="DB Icon" style="width:128px;height:128px;" id = "dbimage">

	<!-- Form required for User Login  -->
	<div class="login">
		<h1>dbRobinhood Login</h1>
	    <form method="post" action="" id="loginForm">
	    	<input type="text" id="username" name="usr" placeholder="Username" required="required" />
	        <input type="password" id="password" name="pwd" placeholder="Password" required="required" />
			<button type="submit" value="Submit" id = "submit" class="btn btn-primary btn-block btn-large">Submit</button>
	    </form>
	</div>

	<script>
	
	// Function is to make password invisible to users
	function staroutpassword() {
	    var x = document.getElementById("password");
	    if (x.type === "password") {
	        x.type = "text";
	    } else {
	        x.type = "password";
	    }
	}
	
	
	var a = document.getElementById("submit");
	var username;
	var password;
	
	// When button is clicked take user input and store in variable username and password
	a.addEventListener("click",function(){
	    username = document.getElementById("username").value;
		password = document.getElementById("password").value;
	},false);
	
	</script>


	<p>
	<div id="userIdMessage"></div>
	</p>
</body>
</html>
