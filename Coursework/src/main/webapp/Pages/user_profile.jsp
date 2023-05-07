<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import="java.util.List" %>
<%@page import="controller.statemanagement.SessionManage"%>
<%@page import="model.PasswordEncryptionWithAes" %>

<%! SessionManage mySession = new SessionManage(); %>
<% String mainPath = request.getContextPath(); %>
<% String email = (String) session.getAttribute("email");%>
<!DOCTYPE html>
<html>

<head>
    <title>User Profile</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/user-profile.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/navbar-user.css" />
    <style type="text/css">

    
    </style>
</head>

<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver" 
	url = "jdbc:mysql://localhost:3306/coursework" user="root" password=""/>
	<sql:query var="user" dataSource="${dbConnection}">
    	SELECT * FROM user WHERE email = ?
    	<sql:param value="${email}" />
	</sql:query>
	
	<sql:query var="orders" dataSource="${dbConnection}">
    	SELECT ordered.orderID, product.product_name, product.price, product.brand, orderedproduct.quantity, product.category
    	FROM ordered
    	JOIN orderedproduct ON ordered.orderID = orderedproduct.orderID
    	JOIN product ON orderedproduct.productID = product.productID
    	WHERE ordered.userID = ?
    	<sql:param value="${user.rows[0].userID}" />
	</sql:query>
	
    <header>
        <div class="logo"><a href="${pageContext.request.contextPath}/home.jsp" style="color: white; text-decoration: none;">FashionHub</a></div>
        <nav>
            MY PROFILE
        </nav>
        <div class="right-container">
            <%if(mySession.checkUser(email)){%>
        		<a href="${pageContext.request.contextPath}/Pages/cart_page.jsp"><button class="cart-btn">Go to Cart</button></a>
    		<%}%>
            <form action="
    				<%if(!mySession.checkUser(email)){
    					out.print(mainPath);%>/login.jsp<%
   					} 
    				else { 
    					out.print(mainPath);%>/LogoutServlet<%
   					}%>"
	    		method="post">
	  			<input class="cart-btn" type="submit" value="<%if(mySession.checkUser(email)){%> Logout <%}else{%> Login <%}%>"/>
	    	</form>
        </div>
    </header>
    <main>
        <div class="title">
            <h2>Welcome,<br>to your account</h2>
            <img class="profile-image" src="http://localhost:7070/images/${user.rows[0].imageID}" alt="Profile Picture" id="profilePic">
        </div>

        <div class="tab">
            <button class="tablinks" onclick="openTab(event, 'UserDetails')" id="defaultOpen">User
                Details</button>
            <button class="tablinks" onclick="openTab(event, 'UserOrders')">User Orders</button>
        </div>

        <div id="UserDetails" class="tabcontent">
            <h3>User Details</h3>
            <form action="${pageContext.request.contextPath}/UpdateUserServlet" method="post" enctype="multipart/form-data">
            
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" name="firstName" value="${user.rows[0].first_name}">

                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" name="lastName" value="${user.rows[0].last_name}">

                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="${user.rows[0].address}">

                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${user.rows[0].email}">

                <label for="password">Password</label>
                <input type="password" id="password" name="password" value="">

                <label for="phoneNumber">Phone Number</label>
                <input type="tel" id="phoneNumber" name="phoneNumber" value="${user.rows[0].phoneNumber}">

                <label for="image">Profile Picture</label>
                <input type="file" id="image" name="image">

                <input class="update" type="submit" value="Update">
            </form>
        </div>

        <div id="UserOrders" class="tabcontent">
            <h3>Order History</h3>
            <table>
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Brand</th>
                        <th>Quantity</th>
                        <th>Category</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orders.rows}">
                        <tr>
							<td>${order.product_name}</td>
							<td>${order.price}</td>
							<td>${order.brand}</td>
							<td>${order.quantity}</td>
							<td>${order.category}</td>
                        </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
    <footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>

    <script>
        function openTab(evt, tabName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
        }
        document.getElementById("defaultOpen").click();
    </script>

</body>

</html>