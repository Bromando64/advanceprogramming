<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/login.css" />
</head>
<body style="background-image:url('${pageContext.request.contextPath}/Pages/Images/background.png')">
	<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
	<div class="card" style="margin-top: 100px;">
		<% if (errorMessage != null) { %>
		    <div class="error-message"><%= errorMessage %></div>
		<% } %>
	  <span class="title">Login</span>
	  <form class="form" id="submitForm" action="${pageContext.request.contextPath}/LoginServlet" method="Post">
	    
	    <div class="group">
		    <input placeholder="‎" type="email" id="email" name="email" required="required">
		    <label for="email">Email</label>
	    </div>
		
	    <div class="group">
		    <input placeholder="‎" type="password" id="password" name="password" required="required">
		    <label for="phonenumber">Password</label>
	    </div>
	    <div class="show">
	    	<input type="checkbox" onclick="showFirst()"><label>   Show Password</label>
	    </div>
	    <div class="next">
	   		<a href="${pageContext.request.contextPath}/signup.jsp">Sign Up?</a>
	   	</div>
	    <button type="submit">Login</button>
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