<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import="java.util.List" %>
<%@page import="controller.statemanagement.SessionManage"%>

<%! SessionManage mySession = new SessionManage(); %>
<% String mainPath = request.getContextPath(); %>
<% String email = (String) session.getAttribute("email");%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart | FashionHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/scroll-body.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/cart-page.css">
    <style type="text/css">
	    html, body {
		    height: 100%;
		    margin: 0;
		    display: flex;
		    flex-direction: column;
		}
		
		header {
		    flex-shrink: 0;
		}
		
		main {
		    flex-grow: 1;
		}
		
		footer {
		    flex-shrink: 0;
		}
		    
    </style>
</head>

<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver" 
	url = "jdbc:mysql://localhost:3306/coursework" user="root" password=""/>
    <header>
        <div class="logo">FashionHub</div>
        <nav>
            <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp?category=Men">Men</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp?category=Women">Women</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp">All Products</a>
        </nav>
        <div class="right-container">
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/ProductFilterServlet" method="get">
                    <input type="hidden" name="category" value="${category}">
                    <input type="text" class="search-input" placeholder="Search" name="search">
                    <button type="submit" class="search-btn"><svg xmlns="http://www.w3.org/2000/svg" width="20"
                            height="20" viewBox="0 0 512 512" id="search">
                            <path
                                d="M448.3 424.7L335 311.3c20.8-26 33.3-59.1 33.3-95.1 0-84.1-68.1-152.2-152-152.2-84 0-152 68.2-152 152.2s68.1 152.2 152 152.2c36.2 0 69.4-12.7 95.5-33.8L425 448l23.3-23.3zM120.1 312.6c-25.7-25.7-39.8-59.9-39.8-96.3s14.2-70.6 39.8-96.3 59.9-40 96.2-40c36.3 0 70.5 14.2 96.2 39.9s39.8 59.9 39.8 96.3-14.2 70.6-39.8 96.3c-25.7 25.7-59.9 39.9-96.2 39.9-36.3.1-70.5-14.1-96.2-39.8z">
                            </path>
                        </svg></button>
                </form>
            </div>
            
            <img src="../Pages/banner/cart.png" width="37" height="34">
            
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
        <div class="cart-container">
            <!-- Add cart items here, fetched from the database -->
            <div class="cart-items">
                <!-- Fetch cart items for the user from the database -->
                <sql:query var="user" dataSource="${dbConnection}">
                	SELECT * FROM user WHERE email = ?
                	<sql:param value="${email}" />
                </sql:query>
                <c:forEach var="row" items="${user.rows}">
    				<c:set var="userID" value="${row.userID}" scope="page" />
				</c:forEach>
				<% int userID = (Integer) pageContext.getAttribute("userID"); %>
                <!-- Loop through the cart items and display them here -->
                <sql:query var="cartItems" dataSource="${dbConnection}">
        			SELECT cp.productID, cp.cartID, cp.quantity, p.product_name, p.price, p.brand
        			FROM cartproduct cp
        			INNER JOIN product p ON cp.productID = p.productID
        			INNER JOIN cart c ON cp.cartID = c.cartID
        			WHERE c.userID = ?
        		<sql:param value="${userID}" />
    			</sql:query>
   			    <c:forEach items="${cartItems.rows}" var="item">
			        <div class="cart-item">
			            <table>
					      <thead>
					        <tr>
					          <th>Product Name:</th>
					          <th>Brand:</th>
					          <th>Price:</th>
					          <th>Quantity:</th>
					        </tr>
					      </thead>
					      <tbody>
					        <tr>
					          <td>${item.product_name}</td>
					          <td>${item.brand}</td>
					          <td>${item.price}</td>
					          <td>${item.quantity}</td>
					        </tr>
					      </tbody>
					    </table>
			        </div>
			    </c:forEach>
            </div>
            <div class="cart-summary">
                <h3>Cart Summary</h3>
                    <c:set var="total" value="0" />
				    <c:forEach items="${cartItems.rows}" var="item">
				        <c:set var="total" value="${total + (item.price * item.quantity)}" />
				    </c:forEach>
    				<h3 style="font-family: Rockwell;" > Total: Rs. ${total}</h3>
    				
    				<form action="${pageContext.request.contextPath}/RemoveCartServlet" method="post" onsubmit="return confirmRemoveAllItems()">
       					 <button class="checkout-btn" type="submit">Remove All Items</button>
    				</form>
       				<br/>
	                <form action="${pageContext.request.contextPath}/CheckoutServlet" method="post">
	    				<button class="checkout-btn" type="submit">Proceed to Checkout</button>
					</form>
            </div>
        </div>
    </main>
    <footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>
    <script>
    function confirmRemoveAllItems() {
        return confirm("Are you sure you want to remove all items from the cart?");
    }
</script>
</body>

</html>