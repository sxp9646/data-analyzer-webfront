var rootURL = "rws/services";

//getAllLinksAndTags();
$.ajax({
	method: 'GET',
	url: rootURL+'/',
	dataType: "json", // data type of response
	success : function(data) {
		console.log(data);
	}
});
function getAllLinksAndTags(){
	getAllTags();
	getAllLinks();
}

/**
 * Comment
 */
function validateUserId() 
{
    loginFromForm();
}

$(document).ready(function() {
	$( "#loginForm" ).submit(function( event ) {
		loginFromForm()
		event.preventDefault();
	});
});

function getAllTags() {
	console.log('getAllTags');
	$.ajax({
		method: 'GET',
		url: rootURL+'/getAllTags',
		dataType: "json", // data type of response
		success : function(data) {
			$("#tag-list").empty();
			if(data == "fail") {
				alert('error');
			}
			else {
				$.each(data, function (i) {
					$("#tag-list").append( "<a href='#' onclick='getLinkForTag(event)'>" + data[i] + "\t</a>");
				})
			}
		}
	});
}

function getAllLinks() {
	console.log("getAllLinks");
	$.ajax(
            {
		method: "GET",
		url: rootURL+"/getAllURL",
		dataType: "json", // data type of response
		success : function(data) 
                {
                    displayBookmarks(data);
		}
            }
        );
}

function getLinkForTag(e){
	var target = e.target || e.srcElement;
	var tag = target.innerHTML;
	$.ajax({
		method: 'GET',
		url: rootURL+'/get/' + tag,
		dataType: "json", // data type of response
		success : function(data) {
			displayBookmarks(data);
		}
	});
}

function displayBookmarks(data){
	if(data == "fail") {
		alert('error');
	}
	else {
		$("#bookmark-list").empty();
		$.each(data, function (i) {
			$("#bookmark-list").append( "<br><a class='text-info h5' href='"+ data[i].url + "'>" + data[i].url + "</a>");
			$("#bookmark-list").append( "<br><h5>" + data[i].description + "</h5>" );
			$.each(data[i].tags, function (j) {
				$("#bookmark-list").append( "<small class='text-muted'>" + data[i].tags[j] + "\t</small>" );
			})
			$("#bookmark-list").append( "<div class='bookmark-widget'></div>" );
		})
	}
}

function saveNewURLWithInfoFromForm() {
	$.ajax({
		method: 'POST',
		url: rootURL + '/save',
		dataType: "json", // data type of response
		data: $('form').serialize(),
		success: function () {
			$( "#bookmark-success" ).append("<p class='text-success'>Bookmark saved successfully</p>");
			$( 'form' ).trigger("reset");  // reset the form
		}
	});
}

function loginFromForm() {
    formdata = $('form');
    fds = formdata.serialize();
    console.log(fds);
    var request = $.ajax({
		method: 'POST',
		url: rootURL + '/login',
		dataType: "json", // data type of response
		data: fds,
                
		success: function ( result) {
					console.log(result);
					window.location.replace("http://localhost:8080/dbanalyzer/charts.jsp");
					
                    setMessageUsingDOM(result );
                    //$( "#userIdMessage" ).append("<p class='text-success'>You have successfully logged onto the server</p>");
                    $( 'form' ).trigger("reset");  // reset the form
                    //console.log(result);
                    
		}
	});
    request.fail(function( jqXHR, textStatus, errorThrown )
    {
        alert( "Request " + textStatus + ", invalid login details: " + fds );
    });
}

// This function is then used to update the DOM in the web page
function setMessageUsingDOM(user) 
{
    var userMessageElement = document.getElementById("userIdMessage");
    var color;
    var target = $("#userIdMessage");
   
    if( target !== null )
    {
        target.html("<p>DEBUG JSON Representation from the server: " + JSON.stringify(user) + "</p>");
        userMessageElement.style.color = "red";
        var items = [];

        var existingElement = $("#" + user.userID );

        if( existingElement.length > 0 )
            $("#" + user.userID ).remove();

        items.push( "<li id='" + user.userID + "'>" + user.userID + "->" + user.userPwd + "</li>" );

        var userList = $( "<ul/>", {
            "class": "dbgrads",
            html: items.join( "" )
        });
        userList.appendTo( "body" );

        target.html("<p>JSON Representation from the server: " + JSON.stringify(user) + "</p>");
        color = "green";

        userMessageElement.style.color = color;
    }
    else
        target.html("<div>ERROR IN PAGE</div>");
}

//document.getElementById("tables").addEventListener("click", function(e) {
//	tablesclick();
//});
$('#tables').on('click', tablesclick())
function tablesclick() {
	console.log("tables clicked");
	pullfromtable("deal", "");
}
//document.getElementById("tables").addEventListener("click", function(){
//	console.log("tables clicked");
//	pullfromtable("deal", "");
//});

function pullfromtable(tableName, filters){
//	formdata = $('#tables');
//	fds = formdata.serialize();
//	console.log(fds);
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
		}
	});
}

