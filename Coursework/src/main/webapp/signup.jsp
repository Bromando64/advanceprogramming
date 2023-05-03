<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/signup.css" />

</head>
<body style="background-image:url('${pageContext.request.contextPath}/Pages/Images/background.png')">

	<div class="card" style="margin-top: 100px;">
	  <span class="title">Sign Up</span>
	  <form class="form">
	    <div class="group">
			    <input placeholder="‎" type="text" required="required" name="firstname">
			    <label for="firstname">First Name</label>
		</div>
		<div class="group">
			    <input placeholder="‎" type="text" required="required" name="lastname">
			    <label for="lastname">Last Name</label>
	    </div>
	    <div class="group">
		    <input placeholder="‎" type="text" id="address" name="address" required="required">
		    <label for="Address">Address</label>
	    </div>
	    <div class="group">
		    <input placeholder="‎" type="text" id="phonenumber" name="phonenumber" required="required">
		    <label for="phonenumber">Phone Number</label>
	    </div>
	    <div class="group">
			    <input placeholder="‎" type="email" required="required" name="email">
			    <label for="email">Email</label>
	    </div>
	    <div class="group">
		    <input placeholder="‎" type="password" id="password" name="password" required="required" value="" >
		    <label for="password">Password</label>
	    </div>
	    <div class="show">
	    	<input type="checkbox" onclick="showFirst()"><label>   Show Password</label>
	    </div>
	    
	   	<div class="next">
	   		<a href="${pageContext.request.contextPath}/login.jsp">Login?</a>
	   	</div>
	    
	    <button type="submit">Sign Up</button>
	  </form>
	</div>
</body>
	<script>
		function showFirst() {
			  var x = document.getElementById("password");
			  if (x.type === "password") {
			    x.type = "text";
			  } else {
			    x.type = "password";
			  }
			}
		
	</script>
</html>